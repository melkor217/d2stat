require 'rails_helper'

RSpec.describe "ability_upgrades/index", type: :view do
  before(:each) do
    assign(:ability_upgrades, [
      AbilityUpgrade.create!(
        :ability => 1,
        :time => 2,
        :level => 3
      ),
      AbilityUpgrade.create!(
        :ability => 1,
        :time => 2,
        :level => 3
      )
    ])
  end

  it "renders a list of ability_upgrades" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
