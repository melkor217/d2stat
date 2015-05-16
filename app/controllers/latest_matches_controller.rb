class LatestMatchesController < ApplicationController
  before_action :set_latest_match, only: [:show, :edit, :update, :destroy]

  # GET /latest_matches
  # GET /latest_matches.json
  def index
    @latest_matches = LatestMatch.all
  end

  # GET /latest_matches/1
  # GET /latest_matches/1.json
  def show
  end

  # GET /latest_matches/new
  def new
    @latest_match = LatestMatch.new
  end

  # GET /latest_matches/1/edit
  def edit
  end

  # POST /latest_matches
  # POST /latest_matches.json
  def create
    @latest_match = LatestMatch.new(latest_match_params)

    respond_to do |format|
      if @latest_match.save
        format.html { redirect_to @latest_match, notice: 'Latest match was successfully created.' }
        format.json { render :show, status: :created, location: @latest_match }
      else
        format.html { render :new }
        format.json { render json: @latest_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /latest_matches/1
  # PATCH/PUT /latest_matches/1.json
  def update
    respond_to do |format|
      if @latest_match.update(latest_match_params)
        format.html { redirect_to @latest_match, notice: 'Latest match was successfully updated.' }
        format.json { render :show, status: :ok, location: @latest_match }
      else
        format.html { render :edit }
        format.json { render json: @latest_match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /latest_matches/1
  # DELETE /latest_matches/1.json
  def destroy
    @latest_match.destroy
    respond_to do |format|
      format.html { redirect_to latest_matches_url, notice: 'Latest match was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_latest_match
      @latest_match = LatestMatch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def latest_match_params
      params[:latest_match]
    end
end
