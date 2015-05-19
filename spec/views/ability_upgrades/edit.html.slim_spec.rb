require 'rails_helper'

RSpec.describe "ability_upgrades/edit", type: :view do
  before(:each) do
    @ability_upgrade = assign(:ability_upgrade, AbilityUpgrade.create!(
      :ability => 1,
      :time => 1,
      :level => 1
    ))
  end

  it "renders the edit ability_upgrade form" do
    render

    assert_select "form[action=?][method=?]", ability_upgrade_path(@ability_upgrade), "post" do

      assert_select "input#ability_upgrade_ability[name=?]", "ability_upgrade[ability]"

      assert_select "input#ability_upgrade_time[name=?]", "ability_upgrade[time]"

      assert_select "input#ability_upgrade_level[name=?]", "ability_upgrade[level]"
    end
  end
end
