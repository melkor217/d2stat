class Account
  include Mongoid::Document
  field :account_id, type: Integer
  field :last_check, type: Time
end
