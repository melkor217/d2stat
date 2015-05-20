require 'rails_helper'

RSpec.describe "mqueues/index", type: :view do
  before(:each) do
    assign(:mqueues, [
      Mqueue.create!(
        :match_id => 1
      ),
      Mqueue.create!(
        :match_id => 1
      )
    ])
  end

  it "renders a list of mqueues" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
