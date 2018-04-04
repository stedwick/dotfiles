# Bond: better IRB completion
require 'bond'
Bond.start

# Pry: better IRB console
if defined?(PryRails::RAILS_PROMPT)
  Pry.config.prompt = PryRails::RAILS_PROMPT
end

Pry.config.pager = false
Pry.config.history.file = "/resume/.irb_history"
