#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# Awesome recurrent task...
#
GetMatchesJob.perform_later
FullScanJob.perform_later
Rails.logger.info "#{Time.now} running rufus"
s.every '12m' do
  FullScanJob.perform_later
  GetMatchesJob.perform_later
end