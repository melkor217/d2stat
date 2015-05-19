require 'rails_helper'

RSpec.describe "ability_upgrades/new", type: :view do
  before(:each) do
    assign(:ability_upgrade, AbilityUpgrade.new(
      :ability => 1,
      :time => 1,
      :level => 1
    ))
  end

  it "renders new ability_upgrade form" do
    render

    assert_select "form[action=?][method=?]", ability_upgrades_path, "post" do

      assert_select "input#ability_upgrade_ability[name=?]", "ability_upgrade[ability]"

      assert_select "input#ability_upgrade_time[name=?]", "ability_upgrade[time]"

      assert_select "input#ability_upgrade_level[name=?]", "ability_upgrade[level]"
    end
  end
end
