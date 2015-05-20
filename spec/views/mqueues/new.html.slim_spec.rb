require 'rails_helper'

RSpec.describe "mqueues/new", type: :view do
  before(:each) do
    assign(:mqueue, Mqueue.new(
      :match_id => 1
    ))
  end

  it "renders new mqueue form" do
    render

    assert_select "form[action=?][method=?]", mqueues_path, "post" do

      assert_select "input#mqueue_match_id[name=?]", "mqueue[match_id]"
    end
  end
end
