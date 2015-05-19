require "rails_helper"

RSpec.describe PicksBansController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/picks_bans").to route_to("picks_bans#index")
    end

    it "routes to #new" do
      expect(:get => "/picks_bans/new").to route_to("picks_bans#new")
    end

    it "routes to #show" do
      expect(:get => "/picks_bans/1").to route_to("picks_bans#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/picks_bans/1/edit").to route_to("picks_bans#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/picks_bans").to route_to("picks_bans#create")
    end

    it "routes to #update" do
      expect(:put => "/picks_bans/1").to route_to("picks_bans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/picks_bans/1").to route_to("picks_bans#destroy", :id => "1")
    end

  end
end
