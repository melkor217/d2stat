require 'net/http'

class GetMatchesJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :scan_new_games





  def get_json(start_at_match_id=nil)
    data = SteamAPI.get_history(start_at_match_id)
    if not data.empty? and data['result']['num_results'] > 0
      logger.info "start from #{start_at_match_id}"
      count = 0
      data['result']['matches'].each do |match|
        if Match.where(match_id: match['match_id']).count == 0
          count += 1
          s = Redis::Semaphore.new(:add_to_queue)
          s.lock do
            Mqueue.find_or_create_by(match_id: match['match_id']).save
          end
        end
        #Match.add_match match
      end
      logger.error "Added #{count} latest"
      if data['result']['results_remaining'] > 0
        get_json(data['result']['matches'].last['match_id'])
      end
    end
  end

  def perform(*args)
    # Do something later
    get_json
    sleep(30)
    queue = Sidekiq::Queue.new(:scan_new_games)
    ([queue.limit, 5].max - queue.size).times do
      self.class.perform_later
    end
  end
end
