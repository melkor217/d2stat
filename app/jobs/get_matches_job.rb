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
#      match['players'].each do |player|
#        add_player(player, record)
#      end
      add_players(match['players'], record)
      match.delete('players')
      record.from_json(match.to_json)
      logger.info('saved %s' % match['match_id'])
      record.save
    else
      logger.info('skip  %s' % match['match_id'])
    end
  end

  def add_account(account_id)
    data = SteamAPI.get_account(account_id)
    if data['response']['players']
      player = data['response']['players'].first
      if player
        query = Account.where(account_id: account_id)
        if not query.exists?
          record = Account.new
          record.from_json(player.to_json)
          record.last_check = Time.now
          record.save
          return player['personaname']
        else
          logger.error query.find()
        end
      end
    end
  end

  def add_players(players, match)
    # array of 32bit account_ids
    account_ids = players.map do |player|
      player['account_id']
    end
    # database records for each player

    accounts_data = SteamAPI.get_account(account_ids)
    if accounts_data['response']['players']
      accounts = accounts_data['response']['players']
    end
    accounts.each do |account|
      # players that matches account
      matched_players = players.select do |player|
        player['account_id'] == account['account_id']
      end
      matched_players.each do |player|
        player['personaname'] = account['personaname']
        logger.error "YAY found #{player}"
      end
      # TODO: save accounts and add nickname to players
    end
    records = players.map do |player|
      record = Player.new
      record.from_json(player.to_json)
      record.save
    end
  end

  def add_player(player, match)
    add_account(player['account_id'])
    record = Player.new
    record.from_json (player.to_json)
    match.players.push record
    record.save
    match.save
  end


  def get_json(start_at_match_id=nil)
    data = SteamAPI.get_history(start_at_match_id)
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
