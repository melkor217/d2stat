#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# Awesome recurrent task...
#
s.every '15m' do
  Rails.logger.info "#{Time.now} running rufus"
  GetMatchesJob.perform_later
end