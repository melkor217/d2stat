class Account
  include Mongoid::Document
  field :account_id, type: BigDecimal
  field :steamid, type: BigDecimal
  field :profilestate, type: Integer
  field :personaname, type: String
  field :lastlogoff, type: Integer
  field :profileurl, type: String
  field :avatar, type: String
  field :avatarmedium, type: String
  field :avatarfull, type: String
  field :personastate, type: Integer
  field :primaryclanid, type: BigDecimal
  field :timecreated, type: Integer
  field :personastateflags, type: Integer
  field :gameextrainfo, type: String
  field :gameid, type: Integer
  field :loccountrycode, type: String
  field :locstatecode, type: Integer
  field :last_check, type: DateTime
end
