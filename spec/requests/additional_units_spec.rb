require 'rails_helper'

RSpec.describe "AdditionalUnits", type: :request do
  describe "GET /additional_units" do
    it "works! (now write some real specs)" do
      get additional_units_path
      expect(response).to have_http_status(200)
    end
  end
end
