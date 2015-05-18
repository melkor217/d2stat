require "rails_helper"

RSpec.describe KeysController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/keys").to route_to("keys#index")
    end

    it "routes to #new" do
      expect(:get => "/keys/new").to route_to("keys#new")
    end

    it "routes to #show" do
      expect(:get => "/keys/1").to route_to("keys#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/keys/1/edit").to route_to("keys#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/keys").to route_to("keys#create")
    end

    it "routes to #update" do
      expect(:put => "/keys/1").to route_to("keys#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/keys/1").to route_to("keys#destroy", :id => "1")
    end

  end
end
