require 'rails_helper'

RSpec.describe "ScannerStatuses", type: :request do
  describe "GET /scanner_statuses" do
    it "works! (now write some real specs)" do
      get scanner_statuses_path
      expect(response).to have_http_status(200)
    end
  end
end
