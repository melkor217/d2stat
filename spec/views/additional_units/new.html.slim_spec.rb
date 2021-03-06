require 'rails_helper'

RSpec.describe "additional_units/new", type: :view do
  before(:each) do
    assign(:additional_unit, AdditionalUnit.new(
      :unitname => "MyString",
      :item_0 => 1,
      :item_1 => 1,
      :item_2 => 1,
      :item_3 => 1,
      :item_4 => 1,
      :item_5 => 1
    ))
  end

  it "renders new additional_unit form" do
    render

    assert_select "form[action=?][method=?]", additional_units_path, "post" do

      assert_select "input#additional_unit_unitname[name=?]", "additional_unit[unitname]"

      assert_select "input#additional_unit_item_0[name=?]", "additional_unit[item_0]"

      assert_select "input#additional_unit_item_1[name=?]", "additional_unit[item_1]"

      assert_select "input#additional_unit_item_2[name=?]", "additional_unit[item_2]"

      assert_select "input#additional_unit_item_3[name=?]", "additional_unit[item_3]"

      assert_select "input#additional_unit_item_4[name=?]", "additional_unit[item_4]"

      assert_select "input#additional_unit_item_5[name=?]", "additional_unit[item_5]"
    end
  end
end
