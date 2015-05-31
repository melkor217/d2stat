class MatchesController < ApplicationController
  before_action :set_match, only: [:show]

  # GET /matches
  # GET /matches.json
  def index
    page = params[:page].to_i.abs
    per_page = 30
    @matches = Match.where(lobby_id: 7, skill: 3).order_by(match_seq_num: :desc).skip(page*per_page).limit(per_page)
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def match_params
      params.require(:match).permit(:match_id, :match_seq_num, :start_time, :lobby_type, :radiant_team_id, :dire_team_id)
    end
end
