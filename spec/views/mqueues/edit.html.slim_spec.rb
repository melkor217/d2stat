require 'rails_helper'

RSpec.describe "mqueues/edit", type: :view do
  before(:each) do
    @mqueue = assign(:mqueue, Mqueue.create!(
      :match_id => 1
    ))
  end

  it "renders the edit mqueue form" do
    render

    assert_select "form[action=?][method=?]", mqueue_path(@mqueue), "post" do

      assert_select "input#mqueue_match_id[name=?]", "mqueue[match_id]"
    end
  end
end
