class StatsController < ApplicationController
  def index
    @mqcount = Redis.new.scard(:mq)
    @mqcount_high = Redis.new.scard(:mq_high)
    @ac_count = Account.count
    @matches = Match
    @accounts = Account
    @acc = session['account']
    @pqcount = Pqueue.count
  end
end

