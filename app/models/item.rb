class Item
  include Mongoid::Document

  field :name, type: String
  field :_id, type: Integer, default: ->{ id }

  has_many :players

  def image
    if id > 0
      return "http://cdn.dota2.com/apps/dota2/images/items/#{name}_lg.png"
    end
    return nil
  end
end

