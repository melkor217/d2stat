require 'rails_helper'

RSpec.describe "winrates/show", type: :view do
  before(:each) do
    @winrate = assign(:winrate, Winrate.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
