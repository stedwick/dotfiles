# Kubernetes

export K8S_ROOT="$RESUME_ROOT/k8s"
export K8S_NAMESPACE="resume-development"

[ -r "$HOME/.bashrc.k8s.secret.sh" ] && source "$HOME/.bashrc.k8s.secret.sh"

[ -n "$(type -t kubectl)" ]  && source <(kubectl  completion bash)
[ -n "$(type -t minikube)" ] && source <(minikube completion bash)

function knamespace() {
  if [ "$1" = "unset" ]; then
    kubectl config set-context "$(kubectl config current-context)" --namespace="" 1>/dev/null
  elif [ -n "$1" ]; then
    kubectl config set-context "$(kubectl config current-context)" --namespace="$1" 1>/dev/null
  else
    kubectl config view | grep namespace | sed 's/.*: //'
  fi
}
completions="unset default resume-development resume-production resume-staging resume-test"
complete -W "$completions" knamespace
if [ -n "$(type -t kubectl)" ]; then
  kubectl config set-context minikube 1>/dev/null
  knamespace "$K8S_NAMESPACE"
fi

alias k="kubectl"
alias kg="kubectl get"
alias kga="kubectl get all"
alias kd="kubectl delete"
alias kdA="kubectl delete hpa,deploy,svc,cm --all"
alias kexec="kubectl exec -it"
alias dkadminer="docker run -d --rm --name adminer -p 8080:8080 --network '$K8S_NAMESPACE' adminer"

function klogs() {
  kubectl logs -f "deployment/$1" "$@"
}
completions="lb web db app"
complete -W "$completions" klogs

function krestart() {
  kubectl patch -p '{"spec":{"template":{"metadata":{"labels":{"k8s_apply_date":"'$(date +"%s")'"}}}}}' deployment "$@"
}
completions="lb web db app"
complete -W "$completions" krestart

function ka() {
  export K8S_APPLY_DATE="$(date +%s)" # Restart pods even if nothing changes
  [ "$1" = "-f" ] && shift
  local fil="$1"
  shift
  cat "$fil" | envsubst | kubectl apply -f - "$@"
  unset K8S_APPLY_DATE
}

function kdeploy() {
  eval "$K8S_ROOT/bin/deploy.sh $@"
}

function krun() {
  local image="$1"
  shift
  local pod="${image#*_}"
  local pod="${pod//_/-}"-run-"$RANDOM"
  kubectl run --image="$image" -it --rm --restart=Never "$pod" "$@"
}

