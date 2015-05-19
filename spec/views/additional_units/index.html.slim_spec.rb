require 'rails_helper'

RSpec.describe "additional_units/index", type: :view do
  before(:each) do
    assign(:additional_units, [
      AdditionalUnit.create!(
        :unitname => "Unitname",
        :item_0 => 1,
        :item_1 => 2,
        :item_2 => 3,
        :item_3 => 4,
        :item_4 => 5,
        :item_5 => 6
      ),
      AdditionalUnit.create!(
        :unitname => "Unitname",
        :item_0 => 1,
        :item_1 => 2,
        :item_2 => 3,
        :item_3 => 4,
        :item_4 => 5,
        :item_5 => 6
      )
    ])
  end

  it "renders a list of additional_units" do
    render
    assert_select "tr>td", :text => "Unitname".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
