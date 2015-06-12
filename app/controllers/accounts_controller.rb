class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.page(params[:page])
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  def edit
    Pqueue.find_or_create_by(account_id: params[:id]).update(prio: 10)
    render 'accounts/show'
  end

  def mathces
    render :'matches/index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:account_id, :steamid, :profilestate, :personaname, :lastlogoff, :profileurl, :avatar, :avatarmedium, :avatarfull, :personastate, :primaryclanid, :timecreated, :personastateflags, :gameextrainfo, :gameid, :loccountrycode, :locstatecode, :last_check)
    end
end
