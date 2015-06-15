require "rails_helper"

RSpec.describe WinratesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/winrates").to route_to("winrates#index")
    end

    it "routes to #new" do
      expect(:get => "/winrates/new").to route_to("winrates#new")
    end

    it "routes to #show" do
      expect(:get => "/winrates/1").to route_to("winrates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/winrates/1/edit").to route_to("winrates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/winrates").to route_to("winrates#create")
    end

    it "routes to #update" do
      expect(:put => "/winrates/1").to route_to("winrates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/winrates/1").to route_to("winrates#destroy", :id => "1")
    end

  end
end
