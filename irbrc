IRB.conf[:SAVE_HISTORY] = 100000
IRB.conf[:HISTORY_FILE] = '~/.irb-history'
if (require 'rails/console/app' rescue false)
  extend Rails::ConsoleMethods
end

