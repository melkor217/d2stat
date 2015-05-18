require 'rails_helper'

RSpec.describe "accounts/new", type: :view do
  before(:each) do
    assign(:account, Account.new(
      :account_id => "",
      :steamid => "",
      :profilestate => 1,
      :personaname => "MyString",
      :lastlogoff => 1,
      :profileurl => "MyString",
      :avatar => "MyString",
      :avatarmedium => "MyString",
      :avatarfull => "MyString",
      :personastate => 1,
      :primaryclanid => "",
      :timecreated => 1,
      :personastateflags => 1,
      :gameextrainfo => "MyString",
      :gameid => 1,
      :loccountrycode => "MyString",
      :locstatecode => 1,
      :last_check => ""
    ))
  end

  it "renders new account form" do
    render

    assert_select "form[action=?][method=?]", accounts_path, "post" do

      assert_select "input#account_account_id[name=?]", "account[account_id]"

      assert_select "input#account_steamid[name=?]", "account[steamid]"

      assert_select "input#account_profilestate[name=?]", "account[profilestate]"

      assert_select "input#account_personaname[name=?]", "account[personaname]"

      assert_select "input#account_lastlogoff[name=?]", "account[lastlogoff]"

      assert_select "input#account_profileurl[name=?]", "account[profileurl]"

      assert_select "input#account_avatar[name=?]", "account[avatar]"

      assert_select "input#account_avatarmedium[name=?]", "account[avatarmedium]"

      assert_select "input#account_avatarfull[name=?]", "account[avatarfull]"

      assert_select "input#account_personastate[name=?]", "account[personastate]"

      assert_select "input#account_primaryclanid[name=?]", "account[primaryclanid]"

      assert_select "input#account_timecreated[name=?]", "account[timecreated]"

      assert_select "input#account_personastateflags[name=?]", "account[personastateflags]"

      assert_select "input#account_gameextrainfo[name=?]", "account[gameextrainfo]"

      assert_select "input#account_gameid[name=?]", "account[gameid]"

      assert_select "input#account_loccountrycode[name=?]", "account[loccountrycode]"

      assert_select "input#account_locstatecode[name=?]", "account[locstatecode]"

      assert_select "input#account_last_check[name=?]", "account[last_check]"
    end
  end
end
