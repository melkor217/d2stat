require 'rails_helper'

RSpec.describe "Mqueues", type: :request do
  describe "GET /mqueues" do
    it "works! (now write some real specs)" do
      get mqueues_path
      expect(response).to have_http_status(200)
    end
  end
end
