require 'rails_helper'

RSpec.describe "latest_matches/new", type: :view do
  before(:each) do
    assign(:latest_match, LatestMatch.new())
  end

  it "renders new latest_match form" do
    render

    assert_select "form[action=?][method=?]", latest_matches_path, "post" do
    end
  end
end
