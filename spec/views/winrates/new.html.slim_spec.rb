require 'rails_helper'

RSpec.describe "winrates/new", type: :view do
  before(:each) do
    assign(:winrate, Winrate.new())
  end

  it "renders new winrate form" do
    render

    assert_select "form[action=?][method=?]", winrates_path, "post" do
    end
  end
end
