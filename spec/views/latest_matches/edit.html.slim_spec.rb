require 'rails_helper'

RSpec.describe "latest_matches/edit", type: :view do
  before(:each) do
    @latest_match = assign(:latest_match, LatestMatch.create!())
  end

  it "renders the edit latest_match form" do
    render

    assert_select "form[action=?][method=?]", latest_match_path(@latest_match), "post" do
    end
  end
end
