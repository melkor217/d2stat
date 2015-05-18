require 'rails_helper'

RSpec.describe "keys/new", type: :view do
  before(:each) do
    assign(:key, Key.new(
      :name => "MyString",
      :value => "MyString"
    ))
  end

  it "renders new key form" do
    render

    assert_select "form[action=?][method=?]", keys_path, "post" do

      assert_select "input#key_name[name=?]", "key[name]"

      assert_select "input#key_value[name=?]", "key[value]"
    end
  end
end
