class Mode
  include Mongoid::Document

  field :name, type: String
  field :active, type: Boolean
  field :_id, type: Integer, default: ->{ id }

  has_many :matches

end
