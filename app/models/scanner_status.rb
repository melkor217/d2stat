class ScannerStatus
  include Mongoid::Document

  field :name, type: String
  field :match_seq_num, type: Integer
  field :start_time, type: DateTime

  index({ name: 1 }, { unique: true})
end
