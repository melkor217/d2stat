require 'rails_helper'

RSpec.describe "AbilityUpgrades", type: :request do
  describe "GET /ability_upgrades" do
    it "works! (now write some real specs)" do
      get ability_upgrades_path
      expect(response).to have_http_status(200)
    end
  end
end
