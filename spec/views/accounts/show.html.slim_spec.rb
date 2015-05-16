require 'rails_helper'

RSpec.describe "accounts/show", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :account_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
