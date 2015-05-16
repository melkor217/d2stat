require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
        :account_id => 1
      ),
      Account.create!(
        :account_id => 1
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
