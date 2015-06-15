class Hero
  include Mongoid::Document

  field :name, type: String
  field :localized_name, type: String
  field :_id, type: Integer, default: ->{ id }

  has_many :matches
  has_many :winrates

  def image
    "http://cdn.dota2.com/apps/dota2/images/heroes/#{self.name}_sb.png"
  end
end

