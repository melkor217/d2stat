class PicksBansController < ApplicationController
  before_action :set_picks_ban, only: [:show, :edit, :update, :destroy]

  # GET /picks_bans
  # GET /picks_bans.json
  def index
    @picks_bans = PicksBan.all
  end

  # GET /picks_bans/1
  # GET /picks_bans/1.json
  def show
  end

  # GET /picks_bans/new
  def new
    @picks_ban = PicksBan.new
  end

  # GET /picks_bans/1/edit
  def edit
  end

  # POST /picks_bans
  # POST /picks_bans.json
  def create
    @picks_ban = PicksBan.new(picks_ban_params)

    respond_to do |format|
      if @picks_ban.save
        format.html { redirect_to @picks_ban, notice: 'Picks ban was successfully created.' }
        format.json { render :show, status: :created, location: @picks_ban }
      else
        format.html { render :new }
        format.json { render json: @picks_ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /picks_bans/1
  # PATCH/PUT /picks_bans/1.json
  def update
    respond_to do |format|
      if @picks_ban.update(picks_ban_params)
        format.html { redirect_to @picks_ban, notice: 'Picks ban was successfully updated.' }
        format.json { render :show, status: :ok, location: @picks_ban }
      else
        format.html { render :edit }
        format.json { render json: @picks_ban.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /picks_bans/1
  # DELETE /picks_bans/1.json
  def destroy
    @picks_ban.destroy
    respond_to do |format|
      format.html { redirect_to picks_bans_url, notice: 'Picks ban was successfully destroyed.' }
      format.json { head :no_content }
    end
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
