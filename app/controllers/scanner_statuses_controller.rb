class ScannerStatusesController < ApplicationController
  before_action :set_scanner_status, only: [:show, :edit, :update, :destroy]

  # GET /scanner_statuses
  # GET /scanner_statuses.json
  def index
    @scanner_statuses = ScannerStatus.all
  end

  # GET /scanner_statuses/1
  # GET /scanner_statuses/1.json
  def show
  end

  # GET /scanner_statuses/new
  def new
    @scanner_status = ScannerStatus.new
  end

  # GET /scanner_statuses/1/edit
  def edit
  end

  # POST /scanner_statuses
  # POST /scanner_statuses.json
  def create
    @scanner_status = ScannerStatus.new(scanner_status_params)

    respond_to do |format|
      if @scanner_status.save
        format.html { redirect_to @scanner_status, notice: 'Scanner status was successfully created.' }
        format.json { render :show, status: :created, location: @scanner_status }
      else
        format.html { render :new }
        format.json { render json: @scanner_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scanner_statuses/1
  # PATCH/PUT /scanner_statuses/1.json
  def update
    respond_to do |format|
      if @scanner_status.update(scanner_status_params)
        format.html { redirect_to @scanner_status, notice: 'Scanner status was successfully updated.' }
        format.json { render :show, status: :ok, location: @scanner_status }
      else
        format.html { render :edit }
        format.json { render json: @scanner_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scanner_statuses/1
  # DELETE /scanner_statuses/1.json
  def destroy
    @scanner_status.destroy
    respond_to do |format|
      format.html { redirect_to scanner_statuses_url, notice: 'Scanner status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scanner_status
      @scanner_status = ScannerStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scanner_status_params
      params.require(:scanner_status).permit(:match_seq_num)
    end
end
