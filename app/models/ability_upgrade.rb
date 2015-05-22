class AbilityUpgrade
  include Mongoid::Document
  field :ability, type: Integer
  field :time, type: Integer
  field :level, type: Integer

  embedded_in :player
end
