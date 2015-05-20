require "rails_helper"

RSpec.describe MqueuesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/mqueues").to route_to("mqueues#index")
    end

    it "routes to #new" do
      expect(:get => "/mqueues/new").to route_to("mqueues#new")
    end

    it "routes to #show" do
      expect(:get => "/mqueues/1").to route_to("mqueues#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/mqueues/1/edit").to route_to("mqueues#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/mqueues").to route_to("mqueues#create")
    end

    it "routes to #update" do
      expect(:put => "/mqueues/1").to route_to("mqueues#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/mqueues/1").to route_to("mqueues#destroy", :id => "1")
    end

  end
end
