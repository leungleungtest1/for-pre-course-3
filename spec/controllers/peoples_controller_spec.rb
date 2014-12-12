require 'spec_helper'
require 'fabrication'
require 'faker'

describe PeoplesController do
  describe "GET index"do
    let(:alice) {Fabricate(:user)}
    let(:bob) {Fabricate(:user)}
    let(:tony) {Fabricate(:user)}
    before do
      session[:user_id] = alice.id
      alice.leaders << bob
      alice.leaders << tony
    end

    it "without authenticated user" do
      session[:user_id] = nil
      get :index
      expect(response).to redirect_to sign_in_path
    end

    it "set a instance variable" do
      get :index
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe "DELETE destroy" do
    let(:alice) {Fabricate(:user)}
    let(:bob) {Fabricate(:user)}
    let(:tony) {Fabricate(:user)}
    before do
      session[:user_id] = alice.id
      alice.leaders << bob
      alice.leaders << tony
    end
    it "without authenticated user" do
      session[:user_id] = nil
      delete :destroy, id: bob.id
      expect(response).to redirect_to sign_in_path
    end
    it "remove the selected leader from the user list" do
      delete :destroy, id: bob.id
      expect(alice.leaders.count).to eq(1)
    end
    it "flash a success message" do
      delete :destroy, id: bob.id
      expect(flash[:success]).not_to be_nil
    end
    it "render people page" do
      delete :destroy, id: bob.id
      expect(response).to redirect_to peoples_path
    end
  end

  describe "POST create" do
    it "without authenticated user redirect to sign in page" do 
      post :create, id: 1
      expect(response).to redirect_to sign_in_path
    end
    context "with valid entry" do
      let(:alice) {Fabricate(:user)}
      let(:bob) {Fabricate(:user)}
      before do
        set_current_user(alice)
      end
      it "create a new leader for current user" do
        post :create, id: bob.id
        expect(alice.leaders.count).to eq(1)
      end
      it "flash success message" do
        post :create, id: bob.id
        expect(flash[:success]).not_to be_nil
      end
      it "redirect people page" do
        post :create, id: bob.id
        expect(response).to redirect_to peoples_path
      end
    end
      context "with invalid entry" do
      let(:alice) {Fabricate(:user)}
      let(:bob) {Fabricate(:user)}
      before do
        set_current_user(alice)
      end
      it "does not create a new leader of himself" do
        post :create, id: alice.id
        expect(alice.leaders.count).to eq(0)
      end
      it "does not create a new leader when it already exists" do
        tony = Fabricate(:user)
        relationship = Fabricate(:relationship, leader_id: tony.id, follower_id: alice.id)
        post :create, id: tony.id
        expect(alice.leaders.count).to eq(1)
      end
      it "with invalid entry, flash error" do
        post :create, id: alice.id
        expect(flash[:error]).not_to be_nil
      end
      it "render template user" do
        post :create, id: alice.id
        expect(response).to render_template "users/show"
      end
    end
  end
end