require 'rails_helper'

RSpec.describe "scanner_statuses/edit", type: :view do
  before(:each) do
    @scanner_status = assign(:scanner_status, ScannerStatus.create!(
      :match_seq_num => 1
    ))
  end

  it "renders the edit scanner_status form" do
    render

    assert_select "form[action=?][method=?]", scanner_status_path(@scanner_status), "post" do

      assert_select "input#scanner_status_match_seq_num[name=?]", "scanner_status[match_seq_num]"
    end
  end
end
