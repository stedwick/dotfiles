FROM ruby
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y postgresql-client
RUN mkdir /resume
WORKDIR /resume
COPY Gemfile /resume/Gemfile
COPY Gemfile.lock /resume/Gemfile.lock
RUN bundle install
COPY .inputrc /root/.inputrc
VOLUME /resume
# CMD ["bin/rails", "server"]
