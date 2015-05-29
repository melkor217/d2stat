class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def new
    @qwe = request.env['omniauth.auth']['provider']
  end

  def create
    auth_hash = request.env['omniauth.auth']

    @authorization = Authorization.where(provider: auth_hash["provider"], uid: auth_hash["uid"]).first
    if @authorization
      render :text => "Welcome back #{@authorization.account.account_id}! You have already signed up."
    else
      id64 = auth_hash['uid'].to_i
      id32 = id64 - 76561197960265728
      accounts = Account.where(account_id: id32)
      if accounts.count > 0
        account = accounts.first
      else
        accounts_data = Dota.api.get('ISteamUser', 'GetPlayerSummaries', 'v002', steamids: id64.to_s)
        logger.error accounts_data
        accounts = accounts_data['response']['players']
        account = Account.add_account(accounts, id32)
      end
      logger.error 'LOL HA'
      logger.error account
      authrecord = Authorization.new(:provider => auth_hash['provider'], :uid => auth_hash['uid'], :account_id => auth_hash['uid'])
      account.authorizations.push authrecord
      authrecord.save
      account.save

      render :text => "Hi #{account.account_id}! You've signed up."
    end
  end

  def failure
  end
end
