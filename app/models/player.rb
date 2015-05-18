class Player
  # Player means not account, but "dat pudga in dis gaem"
  include Mongoid::Document
  field :account_id, type: BigDecimal
  field :player_slot, type: Integer
  field :hero_id, type: Integer
  field :personaname, type: String
  belongs_to :match
  belongs_to :account
end
