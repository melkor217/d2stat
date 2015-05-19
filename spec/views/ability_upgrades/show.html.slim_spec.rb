require 'rails_helper'

RSpec.describe "ability_upgrades/show", type: :view do
  before(:each) do
    @ability_upgrade = assign(:ability_upgrade, AbilityUpgrade.create!(
      :ability => 1,
      :time => 2,
      :level => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
