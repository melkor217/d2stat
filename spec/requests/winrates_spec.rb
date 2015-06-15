require 'rails_helper'

RSpec.describe "Winrates", type: :request do
  describe "GET /winrates" do
    it "works! (now write some real specs)" do
      get winrates_path
      expect(response).to have_http_status(200)
    end
  end
end
