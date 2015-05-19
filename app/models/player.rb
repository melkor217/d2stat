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

  has_many :ability_upgrades
  has_many :additional_units
  belongs_to :match
  belongs_to :account


  def self.add_players(players, match)
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
      player['additional_units'].each do |additional_unit|
        unitrecord = AdditionalUnit.new(additional_unit)
        record.additional_units.push unitrecord
        unitrecord.save
      end if player['additional_units']
      record.update(player.select { |key| key != 'ability_upgrades' and key != 'additional_units' })
      match.players.push record
      Account.add_account(accounts, player['account_id'], record)
      record.save
    end
  end
end
