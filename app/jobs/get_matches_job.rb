require 'net/http'

class GetMatchesJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :scan_new_games



  def add_match(match)
    count = Match.where(match_id: match['match_id']).count
    if count > 1
      logger.fatal 'ERROR COUNT %i %i' % [count, match['match_id']]
    end
    logger.debug count
    if Match.where(match_id: match['match_id']).count == 0
      record = Match.new
      match['players'].each do |player|
        add_player(player, record)
      end
      match.delete('players')
      record.from_json(match.to_json)
      logger.info('saved %s' % match['match_id'])
      record.save
    else
      logger.info('skip  %s' % match['match_id'])
    end
  end

  def add_player(player, match)
    record = Player.new
    record.from_json (player.to_json)
    match.players.push record
    record.save
    match.save
  end

  def get_json(start_at_match_id=nil)
    resp = Net::HTTP.get_response(URI.parse(SteamAPI.get_history_url(start_at_match_id)))
    data = JSON.parse(resp.body)
    if not data.empty? and data['result']['num_results'] > 0
      logger.info "start from #{start_at_match_id}"
      data['result']['matches'].each do |match|
        add_match match
      end
      if data['result']['results_remaining'] > 0
        get_json(data['result']['matches'].last['match_id'])
      end
    end
  end

  def perform(*args)
    # Do something later
    get_json
  end
end
