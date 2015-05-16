require "rails_helper"

RSpec.describe LatestMatchesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/latest_matches").to route_to("latest_matches#index")
    end

    it "routes to #new" do
      expect(:get => "/latest_matches/new").to route_to("latest_matches#new")
    end

    it "routes to #show" do
      expect(:get => "/latest_matches/1").to route_to("latest_matches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/latest_matches/1/edit").to route_to("latest_matches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/latest_matches").to route_to("latest_matches#create")
    end

    it "routes to #update" do
      expect(:put => "/latest_matches/1").to route_to("latest_matches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/latest_matches/1").to route_to("latest_matches#destroy", :id => "1")
    end

  end
end
