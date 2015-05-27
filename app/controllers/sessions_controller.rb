class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    @authorization = Authorization.where(provider: auth_hash["provider"], uid: auth_hash["uid"]).first
    if @authorization
      render :text => "Welcome back #{@authorization.account.account_id}! You have already signed up."
    else
      account = Account.find(auth_hash['uid'].to_i - 76561197960265728)
      logger.error account
      account.authorizations.build :provider => auth_hash['provider'], :uid => auth_hash['uid'], :account_id => auth_hash['uid']
      account.save

      render :text => "Hi #{account.account_id}! You've signed up."
    end
  end

  def failure
  end
end
