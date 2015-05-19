require 'rails_helper'

RSpec.describe "picks_bans/show", type: :view do
  before(:each) do
    @picks_ban = assign(:picks_ban, PicksBan.create!(
      :is_pick => false,
      :hero_id => 1,
      :team => 2,
      :order => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
