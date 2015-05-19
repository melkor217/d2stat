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
      details = SteamAPI::get_match(match['match_id'])
      if details and details['result']
        match = details['result']
        match['verbose'] = true
      end
      record = Match.new
      add_players(match['players'], record)
      record.update(match.select { |key| key != 'players' })
      logger.info('saved %s' % match['match_id'])
      record.save
    else
      logger.info('skip  %s' % match['match_id'])
    end
  end

  def add_account(accounts, account_id, player)
    matched = accounts.select do |account|
      account['account_id'] == account_id
    end
    if account = matched.first
      criteria = Account.where(account_id: account_id)
      if criteria.exists?
        record = criteria.first
      else
        record = Account.new
      end

      record.update(account)
      record.last_check = Time.now
      record.players.push player
      record.save
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
    logger.info "#{accounts.size} accounts"
    accounts.each do |account|
      # players that matches account
      matched_players = players.select do |player|
        player['account_id'] == account['account_id'].to_i
      end
      matched_players.each do |player|
        player['personaname'] = account['personaname']
      end
    end
    records = players.map do |player|
      record = Player.new
      player['ability_upgrades'].each do |abi_upgrade|
        abirecord = AbilityUpgrade.new(abi_upgrade)
        record.ability_upgrades.push abirecord
        abirecord.save
      end if player['ability_upgrades']
      record.update(player.select { |key| key != 'ability_upgrades' and key != 'additional_units' })
      match.players.push record
      add_account(accounts, player['account_id'], record)
      record.save
    end
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
    sleep(5)
    GetMatchesJob.perform_later
  end
end
