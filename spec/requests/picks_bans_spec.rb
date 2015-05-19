require 'rails_helper'

RSpec.describe "PicksBans", type: :request do
  describe "GET /picks_bans" do
    it "works! (now write some real specs)" do
      get picks_bans_path
      expect(response).to have_http_status(200)
    end
  end
end
