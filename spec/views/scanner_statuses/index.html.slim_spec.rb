require 'rails_helper'

RSpec.describe "scanner_statuses/index", type: :view do
  before(:each) do
    assign(:scanner_statuses, [
      ScannerStatus.create!(
        :match_seq_num => 1
      ),
      ScannerStatus.create!(
        :match_seq_num => 1
      )
    ])
  end

  it "renders a list of scanner_statuses" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
