class Pqueue
  # Queue of players to scan
  include Mongoid::Document
  field :account_id, type: Integer
  index({ account_id: 1 }, { unique: true})
  field :_id, type: Integer, default: ->{ account_id }
end
