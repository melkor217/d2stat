require 'rails_helper'

RSpec.describe "scanner_statuses/new", type: :view do
  before(:each) do
    assign(:scanner_status, ScannerStatus.new(
      :match_seq_num => 1
    ))
  end

  it "renders new scanner_status form" do
    render

    assert_select "form[action=?][method=?]", scanner_statuses_path, "post" do

      assert_select "input#scanner_status_match_seq_num[name=?]", "scanner_status[match_seq_num]"
    end
  end
end
