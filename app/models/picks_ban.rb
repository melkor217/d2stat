class PicksBan
  include Mongoid::Document
  field :is_pick, type: Mongoid::Boolean
  field :hero_id, type: Integer
  field :team, type: Integer
  field :order, type: Integer

  embedded_in :match
end
