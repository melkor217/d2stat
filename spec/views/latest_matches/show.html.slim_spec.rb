require 'rails_helper'

RSpec.describe "latest_matches/show", type: :view do
  before(:each) do
    @latest_match = assign(:latest_match, LatestMatch.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
