class Item
  include Mongoid::Document

  field :name, type: String
  field :_id, type: Integer, default: ->{ id }

  has_many :players
end

