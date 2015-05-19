require "rails_helper"

RSpec.describe AbilityUpgradesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ability_upgrades").to route_to("ability_upgrades#index")
    end

    it "routes to #new" do
      expect(:get => "/ability_upgrades/new").to route_to("ability_upgrades#new")
    end

    it "routes to #show" do
      expect(:get => "/ability_upgrades/1").to route_to("ability_upgrades#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ability_upgrades/1/edit").to route_to("ability_upgrades#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ability_upgrades").to route_to("ability_upgrades#create")
    end

    it "routes to #update" do
      expect(:put => "/ability_upgrades/1").to route_to("ability_upgrades#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ability_upgrades/1").to route_to("ability_upgrades#destroy", :id => "1")
    end

  end
end
