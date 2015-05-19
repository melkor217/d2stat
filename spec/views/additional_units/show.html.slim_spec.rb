require 'rails_helper'

RSpec.describe "additional_units/show", type: :view do
  before(:each) do
    @additional_unit = assign(:additional_unit, AdditionalUnit.create!(
      :unitname => "Unitname",
      :item_0 => 1,
      :item_1 => 2,
      :item_2 => 3,
      :item_3 => 4,
      :item_4 => 5,
      :item_5 => 6
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Unitname/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
  end
end
