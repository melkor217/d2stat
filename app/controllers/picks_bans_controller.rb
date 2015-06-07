class PicksBansController < ApplicationController
  before_action :set_picks_ban, only: [:show]

  # GET /picks_bans
  # GET /picks_bans.json
  def index
    @picks_bans = PicksBan.all
  end

  # GET /picks_bans/1
  # GET /picks_bans/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picks_ban
      @picks_ban = PicksBan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picks_ban_params
      params.require(:picks_ban).permit(:is_pick, :hero_id, :team, :order)
    end
end
