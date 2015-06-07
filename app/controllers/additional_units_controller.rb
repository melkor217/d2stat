class AdditionalUnitsController < ApplicationController
  before_action :set_additional_unit, only: [:show]

  # GET /additional_units
  # GET /additional_units.json
  def index
    @additional_units = AdditionalUnit.all
  end

  # GET /additional_units/1
  # GET /additional_units/1.json
  def show
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
