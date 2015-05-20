class ScannerStatus
  include Mongoid::Document
  field :match_seq_num, type: Integer

  belongs_to :match
end
