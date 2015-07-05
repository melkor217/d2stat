class StatsController < ApplicationController
  def index
    @mqcount = RedisSession.scard(:mq)
    @mqcount_high = RedisSession.scard(:mq_high)
    @ac_count = Account.count
    @matches = Match
    @accounts = Account
    @acc = session['account']
    @pqcount = Pqueue.count
  end
end

