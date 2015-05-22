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
          if Match.add_match(match['match_id'], match['skill'])
            match.remove
          else
            logger.info "will retry later #{match['match_id']}"
          end
        end
      end
      queue = Sidekiq::Queue.new(:process_match)
      ([queue.limit.to_i, 50].max - queue.size.to_i).times do
        self.class.perform_later
      end
    end
  end
  logger.info "finished proc #{self.queue_name}"
end
