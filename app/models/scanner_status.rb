class ScannerStatus
  include Mongoid::Document
  field :match_seq_num, type: Integer
  field :start_time, type: DateTime

end
