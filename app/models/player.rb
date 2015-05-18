class Player
  # Player means not account, but "dat pudga in dis gaem"
  include Mongoid::Document
  field :account_id, type: BigDecimal
  field :player_slot, type: Integer
  field :hero_id, type: Integer
  belongs_to :match
end
