require 'rails_helper'

RSpec.describe "picks_bans/new", type: :view do
  before(:each) do
    assign(:picks_ban, PicksBan.new(
      :is_pick => false,
      :hero_id => 1,
      :team => 1,
      :order => 1
    ))
  end

  it "renders new picks_ban form" do
    render

    assert_select "form[action=?][method=?]", picks_bans_path, "post" do

      assert_select "input#picks_ban_is_pick[name=?]", "picks_ban[is_pick]"

      assert_select "input#picks_ban_hero_id[name=?]", "picks_ban[hero_id]"

      assert_select "input#picks_ban_team[name=?]", "picks_ban[team]"

      assert_select "input#picks_ban_order[name=?]", "picks_ban[order]"
    end
  end
end
