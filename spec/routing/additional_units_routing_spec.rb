require "rails_helper"

RSpec.describe AdditionalUnitsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/additional_units").to route_to("additional_units#index")
    end

    it "routes to #new" do
      expect(:get => "/additional_units/new").to route_to("additional_units#new")
    end

    it "routes to #show" do
      expect(:get => "/additional_units/1").to route_to("additional_units#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/additional_units/1/edit").to route_to("additional_units#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/additional_units").to route_to("additional_units#create")
    end

    it "routes to #update" do
      expect(:put => "/additional_units/1").to route_to("additional_units#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/additional_units/1").to route_to("additional_units#destroy", :id => "1")
    end

  end
end
