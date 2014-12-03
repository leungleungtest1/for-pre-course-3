require 'spec_helper'
require 'fabrication'
require 'faker'

describe UsersController do
  describe 'GET new' do
    it " set a new variable @user" do 
      get :new
      expect(assigns(:user)).to be_instance_of(User)
      expect(assigns(:user)).to be_a_new(User)
    end
    it "render a template of 'new'" do
      get :new
      expect(response).to render_template('new')
    end
  end
  describe "POST create" do
    it "set a variable @categories" do
      cat1 = Fabricate(:category)
      post :create, user: {name:"Bob", password: "123456", email:'user@email.com'}
      expect(assigns(:categories)).to eq(Category.all)
    end
    it "set a variable @user" do 
      post :create, user: {name: "Bob", password: "123456", email:"user@email.com"}
      expect(assigns(:user)).to be_a_instance_of(User)
    end
    it "redirects to a sign in url when @user is valid" do
      post :create, user: {name: "Bob", password: "123456", email: Faker::Internet.email}
      expect(assigns(:user)).not_to be_a_new(User)
      expect(response).to redirect_to sign_in_path
    end
    it "renders a template when @user is not valid" do
      User.create(name: "Bob", password: "123456", email: "user1@email.com")
      post :create, user: {name: "Bob", password: "123456", email: "user1@email.com"}
      expect(response).to render_template('pages/front')
    end
  end
end