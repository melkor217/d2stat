class StatsController < ApplicationController
  def index
    @mqcount = Mqueue.count
    @last_hour_matches = Match.where(:scan_time.gte => (Time.now - 2.hours)).count
    @matches = Match
    @accounts = Account
    @qwe = request.env['omniauth.auth']
  end
end

