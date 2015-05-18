require 'net/http'

class GetMatchesJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :scan_new_games


  def get_history_url(start_at_match_id=nil)
    key_arg = "key=#{@key}&"
    start_arg = ''
    if start_at_match_id
      start_arg = "start_at_match_id=#{start_at_match_id}&"
    end
    url = 'https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?'+start_arg+key_arg
    logger.info url
    return url
  end

  def get_account_url(accont_id)
    account_id64 = str(account_id + 76561197960265728)
    key_arg = "key=#{@key}&"
    id_arg = "steamids=#{account_id}&"
    url = 'https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?'+id_arg+key_arg
  end

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
    resp = Net::HTTP.get_response(URI.parse(get_history_url(start_at_match_id)))
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
    @key = '579DD7729A7A4A6AE9DC5CA730B9644E'
    # Do something later
    get_json
  end
end
