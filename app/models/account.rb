class Account
  include Mongoid::Document
  field :account_id, type: BigDecimal # 32bit
  field :steamid, type: BigDecimal    # 64bit
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
  field :communityvisibilitystate, type: Integer
  field :commentpermission, type: Integer
  field :realname, type: String
  field :loccityid, type: Integer
  field :last_check, type: DateTime
  has_many :players
end
