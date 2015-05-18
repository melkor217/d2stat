require 'rails_helper'

RSpec.describe "accounts/index", type: :view do
  before(:each) do
    assign(:accounts, [
      Account.create!(
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
      ),
      Account.create!(
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
      )
    ])
  end

  it "renders a list of accounts" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Personaname".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Profileurl".to_s, :count => 2
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
    assert_select "tr>td", :text => "Avatarmedium".to_s, :count => 2
    assert_select "tr>td", :text => "Avatarfull".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => "Gameextrainfo".to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Loccountrycode".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
