class PlayersController < ApplicationController
  before_action :set_players, only: [:index]

  # GET /players
  # GET /players.json
  def index
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_players
      @players = Player.where(account_id: params[:id]).order_by(match_id: :desc).page(params[:page]).per(20)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:account_id, :player_slot, :hero_id)
    end
end
