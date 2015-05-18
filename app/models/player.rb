class Player
  include Mongoid::Document
  field :account_id, type: BigDecimal
  field :player_slot, type: Integer
  field :hero_id, type: Integer
  belongs_to :match
end
