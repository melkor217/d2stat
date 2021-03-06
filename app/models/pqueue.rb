class Pqueue
  # Queue of players to scan
  include Mongoid::Document
  field :account_id, type: Integer
  field :prio, type: Integer
  index({ account_id: 1 }, { unique: true})
  index({ prio: 1 }, { unique: false})
  field :_id, type: Integer, default: ->{ account_id }
end
