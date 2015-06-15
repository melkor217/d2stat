require 'rails_helper'

RSpec.describe "winrates/index", type: :view do
  before(:each) do
    assign(:winrates, [
      Winrate.create!(),
      Winrate.create!()
    ])
  end

  it "renders a list of winrates" do
    render
  end
end
