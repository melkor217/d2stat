class Authorization
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: Integer
  field :account_id, type: Integer
  belongs_to :account
end
