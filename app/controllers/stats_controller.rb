class StatsController < ApplicationController
  def index
    @mqcount = Redis.new.scard(:mq)
    @ac_count = Account.count
    @last_hour_matches = Match.where(:scan_time.gte => (Time.now - 2.hours)).count
    @matches = Match
    @accounts = Account
    @acc = session['account']
    @pqcount = Pqueue.count
  end
end

