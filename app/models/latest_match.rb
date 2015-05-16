class LatestMatch
  include Mongoid::Document
  has_one :match
end
