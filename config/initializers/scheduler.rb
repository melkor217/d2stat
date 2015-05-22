#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# Awesome recurrent task...
#
GetMatchesJob.set(queue: :scan_low).perform_later 0
GetMatchesJob.set(queue: :scan_high).perform_later 1
GetMatchesJob.set(queue: :scan_very_high).perform_later 2
FullScanJob.perform_later
ProcessMatchJob.perform_later
Rails.logger.info "#{Time.now} running rufus"
s.every '20m' do
  FullScanJob.perform_later
  GetMatchesJob.set(queue: :scan_low).perform_later 0
  GetMatchesJob.set(queue: :scan_high).perform_later 1
  GetMatchesJob.set(queue: :scan_very_high).perform_later 2
  ProcessMatchJob.perform_later
end