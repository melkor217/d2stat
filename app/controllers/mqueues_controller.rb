class MqueuesController < ApplicationController
  before_action :set_mqueue, only: [:show, :edit, :update, :destroy]

  # GET /mqueues
  # GET /mqueues.json
  def index
    @mqueues = Mqueue.all
  end

  # GET /mqueues/1
  # GET /mqueues/1.json
  def show
  end

  # GET /mqueues/new
  def new
    @mqueue = Mqueue.new
  end

  # GET /mqueues/1/edit
  def edit
  end

  # POST /mqueues
  # POST /mqueues.json
  def create
    @mqueue = Mqueue.new(mqueue_params)

    respond_to do |format|
      if @mqueue.save
        format.html { redirect_to @mqueue, notice: 'Mqueue was successfully created.' }
        format.json { render :show, status: :created, location: @mqueue }
      else
        format.html { render :new }
        format.json { render json: @mqueue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mqueues/1
  # PATCH/PUT /mqueues/1.json
  def update
    respond_to do |format|
      if @mqueue.update(mqueue_params)
        format.html { redirect_to @mqueue, notice: 'Mqueue was successfully updated.' }
        format.json { render :show, status: :ok, location: @mqueue }
      else
        format.html { render :edit }
        format.json { render json: @mqueue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mqueues/1
  # DELETE /mqueues/1.json
  def destroy
    @mqueue.destroy
    respond_to do |format|
      format.html { redirect_to mqueues_url, notice: 'Mqueue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mqueue
      @mqueue = Mqueue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mqueue_params
      params.require(:mqueue).permit(:match_id)
    end
end
