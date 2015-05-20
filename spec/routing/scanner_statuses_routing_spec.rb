require "rails_helper"

RSpec.describe ScannerStatusesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/scanner_statuses").to route_to("scanner_statuses#index")
    end

    it "routes to #new" do
      expect(:get => "/scanner_statuses/new").to route_to("scanner_statuses#new")
    end

    it "routes to #show" do
      expect(:get => "/scanner_statuses/1").to route_to("scanner_statuses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scanner_statuses/1/edit").to route_to("scanner_statuses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/scanner_statuses").to route_to("scanner_statuses#create")
    end

    it "routes to #update" do
      expect(:put => "/scanner_statuses/1").to route_to("scanner_statuses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scanner_statuses/1").to route_to("scanner_statuses#destroy", :id => "1")
    end

  end
end
