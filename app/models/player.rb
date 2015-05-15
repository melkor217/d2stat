class Player
  include Mongoid::Document
  field :account_id, type: Integer
  field :player_slot, type: Integer
  field :hero_id, type: Integer
end
