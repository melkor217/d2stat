class AbilityUpgradesController < ApplicationController
  before_action :set_ability_upgrade, only: [:show, :edit, :update, :destroy]

  # GET /ability_upgrades
  # GET /ability_upgrades.json
  def index
    @ability_upgrades = AbilityUpgrade.all
  end

  # GET /ability_upgrades/1
  # GET /ability_upgrades/1.json
  def show
  end

  # GET /ability_upgrades/new
  def new
    @ability_upgrade = AbilityUpgrade.new
  end

  # GET /ability_upgrades/1/edit
  def edit
  end

  # POST /ability_upgrades
  # POST /ability_upgrades.json
  def create
    @ability_upgrade = AbilityUpgrade.new(ability_upgrade_params)

    respond_to do |format|
      if @ability_upgrade.save
        format.html { redirect_to @ability_upgrade, notice: 'Ability upgrade was successfully created.' }
        format.json { render :show, status: :created, location: @ability_upgrade }
      else
        format.html { render :new }
        format.json { render json: @ability_upgrade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ability_upgrades/1
  # PATCH/PUT /ability_upgrades/1.json
  def update
    respond_to do |format|
      if @ability_upgrade.update(ability_upgrade_params)
        format.html { redirect_to @ability_upgrade, notice: 'Ability upgrade was successfully updated.' }
        format.json { render :show, status: :ok, location: @ability_upgrade }
      else
        format.html { render :edit }
        format.json { render json: @ability_upgrade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ability_upgrades/1
  # DELETE /ability_upgrades/1.json
  def destroy
    @ability_upgrade.destroy
    respond_to do |format|
      format.html { redirect_to ability_upgrades_url, notice: 'Ability upgrade was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ability_upgrade
      @ability_upgrade = AbilityUpgrade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ability_upgrade_params
      params.require(:ability_upgrade).permit(:ability, :time, :level)
    end
end
