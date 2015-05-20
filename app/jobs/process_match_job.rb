require 'net/http'

class ProcessMatchJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :process_match


  def perform(*args)
    # Do something later
    count = Mqueue.count
    if count > 100
      Mqueue.skip(rand(count-30)).limit(20).each do |match|
        s = Redis::Semaphore.new(match['match_id'])
        next if s.exists?
        s.lock do
          logger.info "processing #{match['match_id']}"
          Match.add_match(match['match_id'])
          match.remove
        end
      end
      queue = Sidekiq::Queue.new(:process_match)
      ([queue.limit, 50].max - queue.size).times do
        self.class.perform_later
      end
    end
  end
end
