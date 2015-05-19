require 'rails_helper'

RSpec.describe "picks_bans/index", type: :view do
  before(:each) do
    assign(:picks_bans, [
      PicksBan.create!(
        :is_pick => false,
        :hero_id => 1,
        :team => 2,
        :order => 3
      ),
      PicksBan.create!(
        :is_pick => false,
        :hero_id => 1,
        :team => 2,
        :order => 3
      )
    ])
  end

  it "renders a list of picks_bans" do
    render
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
