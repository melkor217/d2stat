require 'rails_helper'

RSpec.describe "players/new", type: :view do
  before(:each) do
    assign(:player, Player.new(
      :account_id => 1,
      :player_slot => 1,
      :hero_id => 1
    ))
  end

  it "renders new player form" do
    render

    assert_select "form[action=?][method=?]", players_path, "post" do

      assert_select "input#player_account_id[name=?]", "player[account_id]"

      assert_select "input#player_player_slot[name=?]", "player[player_slot]"

      assert_select "input#player_hero_id[name=?]", "player[hero_id]"
    end
  end
end
