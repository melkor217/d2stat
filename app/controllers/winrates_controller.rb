class WinratesController < ApplicationController

  # GET /winrates
  # GET /winrates.json
  def index
    @days = 1
    if (1..9999).include? params[:days].to_i
      @days = params[:days].to_i
    end
  end

end
