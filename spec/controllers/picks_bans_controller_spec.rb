require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe PicksBansController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # PicksBan. As you add validations to PicksBan, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PicksBansController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all picks_bans as @picks_bans" do
      picks_ban = PicksBan.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:picks_bans)).to eq([picks_ban])
    end
  end

  describe "GET #show" do
    it "assigns the requested picks_ban as @picks_ban" do
      picks_ban = PicksBan.create! valid_attributes
      get :show, {:id => picks_ban.to_param}, valid_session
      expect(assigns(:picks_ban)).to eq(picks_ban)
    end
  end

  describe "GET #new" do
    it "assigns a new picks_ban as @picks_ban" do
      get :new, {}, valid_session
      expect(assigns(:picks_ban)).to be_a_new(PicksBan)
    end
  end

  describe "GET #edit" do
    it "assigns the requested picks_ban as @picks_ban" do
      picks_ban = PicksBan.create! valid_attributes
      get :edit, {:id => picks_ban.to_param}, valid_session
      expect(assigns(:picks_ban)).to eq(picks_ban)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PicksBan" do
        expect {
          post :create, {:picks_ban => valid_attributes}, valid_session
        }.to change(PicksBan, :count).by(1)
      end

      it "assigns a newly created picks_ban as @picks_ban" do
        post :create, {:picks_ban => valid_attributes}, valid_session
        expect(assigns(:picks_ban)).to be_a(PicksBan)
        expect(assigns(:picks_ban)).to be_persisted
      end

      it "redirects to the created picks_ban" do
        post :create, {:picks_ban => valid_attributes}, valid_session
        expect(response).to redirect_to(PicksBan.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved picks_ban as @picks_ban" do
        post :create, {:picks_ban => invalid_attributes}, valid_session
        expect(assigns(:picks_ban)).to be_a_new(PicksBan)
      end

      it "re-renders the 'new' template" do
        post :create, {:picks_ban => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested picks_ban" do
        picks_ban = PicksBan.create! valid_attributes
        put :update, {:id => picks_ban.to_param, :picks_ban => new_attributes}, valid_session
        picks_ban.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested picks_ban as @picks_ban" do
        picks_ban = PicksBan.create! valid_attributes
        put :update, {:id => picks_ban.to_param, :picks_ban => valid_attributes}, valid_session
        expect(assigns(:picks_ban)).to eq(picks_ban)
      end

      it "redirects to the picks_ban" do
        picks_ban = PicksBan.create! valid_attributes
        put :update, {:id => picks_ban.to_param, :picks_ban => valid_attributes}, valid_session
        expect(response).to redirect_to(picks_ban)
      end
    end

    context "with invalid params" do
      it "assigns the picks_ban as @picks_ban" do
        picks_ban = PicksBan.create! valid_attributes
        put :update, {:id => picks_ban.to_param, :picks_ban => invalid_attributes}, valid_session
        expect(assigns(:picks_ban)).to eq(picks_ban)
      end

      it "re-renders the 'edit' template" do
        picks_ban = PicksBan.create! valid_attributes
        put :update, {:id => picks_ban.to_param, :picks_ban => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested picks_ban" do
      picks_ban = PicksBan.create! valid_attributes
      expect {
        delete :destroy, {:id => picks_ban.to_param}, valid_session
      }.to change(PicksBan, :count).by(-1)
    end

    it "redirects to the picks_bans list" do
      picks_ban = PicksBan.create! valid_attributes
      delete :destroy, {:id => picks_ban.to_param}, valid_session
      expect(response).to redirect_to(picks_bans_url)
    end
  end

end