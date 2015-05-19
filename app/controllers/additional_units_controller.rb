class AdditionalUnitsController < ApplicationController
  before_action :set_additional_unit, only: [:show, :edit, :update, :destroy]

  # GET /additional_units
  # GET /additional_units.json
  def index
    @additional_units = AdditionalUnit.all
  end

  # GET /additional_units/1
  # GET /additional_units/1.json
  def show
  end

  # GET /additional_units/new
  def new
    @additional_unit = AdditionalUnit.new
  end

  # GET /additional_units/1/edit
  def edit
  end

  # POST /additional_units
  # POST /additional_units.json
  def create
    @additional_unit = AdditionalUnit.new(additional_unit_params)

    respond_to do |format|
      if @additional_unit.save
        format.html { redirect_to @additional_unit, notice: 'Additional unit was successfully created.' }
        format.json { render :show, status: :created, location: @additional_unit }
      else
        format.html { render :new }
        format.json { render json: @additional_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /additional_units/1
  # PATCH/PUT /additional_units/1.json
  def update
    respond_to do |format|
      if @additional_unit.update(additional_unit_params)
        format.html { redirect_to @additional_unit, notice: 'Additional unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @additional_unit }
      else
        format.html { render :edit }
        format.json { render json: @additional_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /additional_units/1
  # DELETE /additional_units/1.json
  def destroy
    @additional_unit.destroy
    respond_to do |format|
      format.html { redirect_to additional_units_url, notice: 'Additional unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_additional_unit
      @additional_unit = AdditionalUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def additional_unit_params
      params.require(:additional_unit).permit(:unitname, :item_0, :item_1, :item_2, :item_3, :item_4, :item_5)
    end
end
