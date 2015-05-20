require 'rails_helper'

RSpec.describe "scanner_statuses/show", type: :view do
  before(:each) do
    @scanner_status = assign(:scanner_status, ScannerStatus.create!(
      :match_seq_num => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
