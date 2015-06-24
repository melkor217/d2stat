class MatchesController < ApplicationController
  before_action :set_match, only: [:show]

  # GET /matches
  # GET /matches.json
  def index
    @skills = [['All skill brackets', ''], ['Unknown', '0'], ['Normal', '1'], ['High', '2'], ['Very High', '3']]
    @matches = Match.all
    if params[:lobby].to_s != '' and Lobby.find(params[:lobby]).active == true
      @matches = @matches.where(lobby: params[:lobby])
    end
    if params[:mode].to_s != '' and Mode.find(params[:mode]).active == true
      @matches = @matches.where(mode: params[:mode])
    end
    if params[:skill].to_s != '' and (0..3).include? params[:skill].to_i
      skill = params[:skill].to_i
      skill = nil if skill.to_i==0
      @matches = @matches.where(skill: skill)
    end
    @matches = @matches.order_by(match_seq_num: :desc)
    @matches = @matches.page(params[:page])
    @matches = @matches.max_scan(50000)
    #@matches = Match.where(lobby_id: 7, skill: 3).order_by(match_seq_num: :desc).page(params[:page])
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
