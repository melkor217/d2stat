class Mqueue
  include Mongoid::Document
  field :match_id, type: Integer
  field :skill, type: Integer
end
