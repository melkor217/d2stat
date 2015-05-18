require 'rails_helper'

RSpec.describe "accounts/show", type: :view do
  before(:each) do
    @account = assign(:account, Account.create!(
      :account_id => "",
      :steamid => "",
      :profilestate => 1,
      :personaname => "Personaname",
      :lastlogoff => 2,
      :profileurl => "Profileurl",
      :avatar => "Avatar",
      :avatarmedium => "Avatarmedium",
      :avatarfull => "Avatarfull",
      :personastate => 3,
      :primaryclanid => "",
      :timecreated => 4,
      :personastateflags => 5,
      :gameextrainfo => "Gameextrainfo",
      :gameid => 6,
      :loccountrycode => "Loccountrycode",
      :locstatecode => 7,
      :last_check => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Personaname/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Profileurl/)
    expect(rendered).to match(/Avatar/)
    expect(rendered).to match(/Avatarmedium/)
    expect(rendered).to match(/Avatarfull/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Gameextrainfo/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/Loccountrycode/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(//)
  end
end
