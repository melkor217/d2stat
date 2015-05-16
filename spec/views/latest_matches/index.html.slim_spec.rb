require 'rails_helper'

RSpec.describe "latest_matches/index", type: :view do
  before(:each) do
    assign(:latest_matches, [
      LatestMatch.create!(),
      LatestMatch.create!()
    ])
  end

  it "renders a list of latest_matches" do
    render
  end
end
