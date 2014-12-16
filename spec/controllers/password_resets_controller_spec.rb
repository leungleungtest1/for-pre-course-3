require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "sets @token" do
      alice = Fabricate(:user)
      alice.update_column(:token, "12345")
      get :show, id: "12345"
      expect(assigns(:token)).to eq("12345")
    end
    it "renders show page when the token is valid" do
      alice = Fabricate(:user)
      alice.update_column(:token, "12345")
      get :show, id: "12345"
      expect(response).to render_template :show
    end
    it "redirect to the expired token page when the token is invalid" do 
      get :show, id: "12345"
      expect(response).to redirect_to expired_token_path
    end    
  end

  describe "POST create" do
    context "with valid token" do
      before do
        @bob = Fabricate(:user,name: "bob", password: "old_password")
        @bob.update_column(:token, "123456")
      end
      it "update the user's password" do
        post :create, token: "123456", password: "new_password"
        expect(@bob.reload.authenticate('new_password')).to be_truthy
      end
      it "redirects to the sign in page" do
        post :create, token: "123456", password: "new_password"
        expect(response).to redirect_to sign_in_path
      end
      it "sets the flash success message" do
        post :create, token: "123456", password: "new_password"
        expect(flash[:success]).to be_present
      end
      it "regenerate the user token" do
        post :create, token: "123456", password: "new_password"
        expect(@bob.reload.token).not_to eq("123456")
      end
    end
    context "with invalid token" do
      it "redirects to the expired_token_path" do
        post :create, token: "123456", password: "some_password"
        expect(response).to redirect_to expired_token_path
      end
    end

  end
end