class Player
  # Player means not account, but "dat pudga in dis gaem"
  include Mongoid::Document
  field :account_id, type: BigDecimal
  field :player_slot, type: Integer
  field :hero_id, type: Integer
  field :personaname, type: String
  field :item_0, type: Integer
  field :item_1, type: Integer
  field :item_2, type: Integer
  field :item_3, type: Integer
  field :item_4, type: Integer
  field :item_5, type: Integer
  field :kills, type: Integer
  field :deaths, type: Integer
  field :assists, type: Integer
  field :leaver_status, type: Integer
  field :gold, type: Integer
  field :last_hits, type: Integer
  field :denies, type: Integer
  field :xp_per_min, type: Integer
  field :gold_per_min, type: Integer
  field :hero_damage, type: Integer
  field :tower_damage, type: Integer
  field :hero_healing, type: Integer
  field :gold_spent, type: Integer
  field :level, type: Integer

  embeds_many :ability_upgrades
  embeds_many :additional_units
  belongs_to :match, index: true
  belongs_to :account, index: true


  def self.add_players(players, match)
    # array of 32bit account_ids
    account_ids = players.map do |player|
      player['account_id']
    end
    account_ids.select! do |id|
      # MAX_INT means anonymous
      id and id.to_i < 4294967295
    end
    # database records for each player

    accounts_data = Dota.api.get('ISteamUser', 'GetPlayerSummaries', steamids: account_ids.map! do |id|
                                                                                 id.to_i + 76561197960265728
                                                                                end.join(',')
    )
    if accounts_data['response']['players']
      accounts = accounts_data['response']['players']['player']
    else
      accounts = []
    end
    logger.info "#{accounts.size} accounts"
    accounts.each do |account|
      # players that matches account
      matched_players = players.select do |player|
        player['account_id'].to_i == (account['steamid'].to_i - 76561197960265728)
      end
      matched_players.each do |player|
        player['personaname'] = account['personaname']
      end
    end
    records = players.map do |player|
      record = Player.new
      player['ability_upgrades'].each do |abi_upgrade|
        abirecord = record.ability_upgrades.new(abi_upgrade)
        record.ability_upgrades.append abirecord
      end if player['ability_upgrades']
      player['additional_units'].each do |additional_unit|
        unitrecord = record.additional_units.new(additional_unit)
        record.additional_units.append unitrecord
      end if player['additional_units']
      match.players.push record
      record.update(player.select { |key| key != 'ability_upgrades' and key != 'additional_units' })
      Account.add_account(accounts, player['account_id'], record)
      record.save
    end
  end
end
