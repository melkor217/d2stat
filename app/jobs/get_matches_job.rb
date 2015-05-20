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
        count += 1
        Match.add_match match
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
    sleep(5)
    GetMatchesJob.perform_later
  end
end
