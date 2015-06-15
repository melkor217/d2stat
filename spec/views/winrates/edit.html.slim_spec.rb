require 'rails_helper'

RSpec.describe "winrates/edit", type: :view do
  before(:each) do
    @winrate = assign(:winrate, Winrate.create!())
  end

  it "renders the edit winrate form" do
    render

    assert_select "form[action=?][method=?]", winrate_path(@winrate), "post" do
    end
  end
end
