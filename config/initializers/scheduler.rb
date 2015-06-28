#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

# Let's use the rufus-scheduler singleton
#
s = Rufus::Scheduler.singleton

# Awesome recurrent task...
#
def enqueue_all()
  GetMatchesJob.set(queue: :scan_low).perform_later 1
  GetMatchesJob.set(queue: :scan_high).perform_later 2
  GetMatchesJob.set(queue: :scan_very_high).perform_later 3
  LatestMatchesJob.perform_later
  FullScanJob.perform_later
  ProcessMatchJob.perform_later
  ProcessPlayersJob.perform_later
end


enqueue_all
Rails.logger.info "#{Time.now} running rufus"
s.every '20m' do
  enqueue_all
end

