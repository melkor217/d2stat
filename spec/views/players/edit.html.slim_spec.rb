require 'rails_helper'

RSpec.describe "players/edit", type: :view do
  before(:each) do
    @player = assign(:player, Player.create!(
      :account_id => 1,
      :player_slot => 1,
      :hero_id => 1
    ))
  end

  it "renders the edit player form" do
    render

    assert_select "form[action=?][method=?]", player_path(@player), "post" do

      assert_select "input#player_account_id[name=?]", "player[account_id]"

      assert_select "input#player_player_slot[name=?]", "player[player_slot]"

      assert_select "input#player_hero_id[name=?]", "player[hero_id]"
    end
  end
end
