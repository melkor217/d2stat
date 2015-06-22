class Patch
  include Mongoid::Document

  field :version, type: String
  field :date, type: DateTime

  index({ date: 1 }, { unique: true})
end
