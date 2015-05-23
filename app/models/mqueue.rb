class Mqueue
  include Mongoid::Document
  field :match_id, type: Integer
  field :skill, type: Integer
  index({ match_id: 1 }, { unique: true})
  field :_id, type: Integer, default: ->{ match_id }
end
