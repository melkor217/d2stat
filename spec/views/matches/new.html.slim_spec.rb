require 'rails_helper'

RSpec.describe "matches/new", type: :view do
  before(:each) do
    assign(:match, Match.new(
      :match_id => 1,
      :match_seq_num => 1,
      :start_time => 1,
      :lobby_type => 1,
      :radiant_team_id => 1,
      :dire_team_id => 1
    ))
  end

  it "renders new match form" do
    render

    assert_select "form[action=?][method=?]", matches_path, "post" do

      assert_select "input#match_match_id[name=?]", "match[match_id]"

      assert_select "input#match_match_seq_num[name=?]", "match[match_seq_num]"

      assert_select "input#match_start_time[name=?]", "match[start_time]"

      assert_select "input#match_lobby_type[name=?]", "match[lobby_type]"

      assert_select "input#match_radiant_team_id[name=?]", "match[radiant_team_id]"

      assert_select "input#match_dire_team_id[name=?]", "match[dire_team_id]"
    end
  end
end
