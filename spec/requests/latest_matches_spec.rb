require 'rails_helper'

RSpec.describe "LatestMatches", type: :request do
  describe "GET /latest_matches" do
    it "works! (now write some real specs)" do
      get latest_matches_path
      expect(response).to have_http_status(200)
    end
  end
end
