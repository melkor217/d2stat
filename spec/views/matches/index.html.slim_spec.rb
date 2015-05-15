require 'rails_helper'

RSpec.describe "matches/index", type: :view do
  before(:each) do
    assign(:matches, [
      Match.create!(
        :match_id => 1,
        :match_seq_num => 2,
        :start_time => 3,
        :lobby_type => 4,
        :radiant_team_id => 5,
        :dire_team_id => 6
      ),
      Match.create!(
        :match_id => 1,
        :match_seq_num => 2,
        :start_time => 3,
        :lobby_type => 4,
        :radiant_team_id => 5,
        :dire_team_id => 6
      )
    ])
  end

  it "renders a list of matches" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
