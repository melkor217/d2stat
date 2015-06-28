class AvgstatsController < ApplicationController
  def index
    @days = 1
    if not params[:mode]
      params[:mode] = '22'
    end
    if (1..9999).include? params[:days].to_i
      @days = params[:days].to_i
    end
    @query = Avgstat.where(:day.gt => @days.days.ago.utc).where(:day.lt => (@days-1).days.ago)
    if params[:mode].to_s != '' and Mode.find(params[:mode]).active == true
      @query = @query.where(mode: params[:mode])
    end
#    @query = Avgstat.where(mode: 1)
  end
end
