class Account
  include Mongoid::Document
  field :account_id, type: Integer # 32bit
  field :steamid, type: Integer    # 64bit
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
  field :lobbysteamid, type: Integer
  field :last_check, type: DateTime
  field :gameserverip, type: String
  field :gameserversteamid, type: Integer
  has_many :players
  has_many :authorizations

  index({ personaname: 1 }, { unique: false})
  #index({ account_id: 1 }, { unique: true})
  field :_id, type: Integer, default: ->{ account_id }

  def self.add_account(accounts, account_id, player=nil)
    # Adds/updates account from json account data, then links it with player
    matched = accounts.select do |account|
      account['steamid'].to_i == (account_id.to_i + 76561197960265728)
    end
    if account = matched.first
      account['last_check'] = Time.now
      account['account_id'] =  account['steamid'].to_i - 76561197960265728
      s = Redis::Semaphore.new('acc:'+account['account_id'].to_s, expiration: 600, redis: RedisSession)
      s.lock(10)
      criteria = Account.where(id: account_id)
      if criteria.exists?
        return true
      else
        record = Account.new(account)
        Pqueue.find_or_create_by(account_id: account['account_id'])
      end
      if player
        player.account = record
      end
      record.save
      s.unlock
      s.delete!
      return record
    else
      return false
    end
  end
end
