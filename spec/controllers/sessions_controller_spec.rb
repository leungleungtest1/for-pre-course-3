require 'spec_helper'
require 'fabrication'
require 'faker'

describe SessionsController do 
  describe 'GET new' do
    it "redirect to home path when user do sign in" do 
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new 
      expect(response).to redirect_to (home_path)
    end
    it "render a template 'new' when user do not sign in " do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    it "set a variable @categories" do
      cat1 = Fabricate(:category)
      post :create
      expect(assigns(:categories)).to eq([cat1])
    end
    it "set a variable user" do
      user = Fabricate(:user)
      post :create, email: user.email
      expect(assigns(:user)).to eq(user)
    end
    it "set session[:user_id] to be user_id when it is authenicated" do
      user = Fabricate(:user)
      post :create, {email: user.email, password: "123456"}
      expect(session[:user_id]).to eq(user.id)
    end
    it "render new template when it cannot be authenicated" do
      user = Fabricate(:user)
      post :create, {email: user.email, password: "1123456"}
      expect(response).to render_template('sessions/new')
    end
    it "sets flash notice when it is authenicated" do
      user = Fabricate(:user)
      post :create, {email: user.email, password: "123456"}
      expect(flash[:notice]).not_to be_blank
    end
  end
  describe 'GET destroy' do
    it "clear session[:user_id]" do
      user= Fabricate(:user)
      session[:user_id] = user.id
      get :destroy
      expect(session[:user_id]).to eq(nil)
    end
    it "redirect to root path" do
      user= Fabricate(:user)
      session[:user_id] = user.id
      get :destroy
      expect(response).to redirect_to(root_path)
    end
    it "get a flash of notice" do
      user= Fabricate(:user)
      session[:user_id] = user.id
      get :destroy
      expect(flash[:notice]).not_to be_blank
    end
  end
end