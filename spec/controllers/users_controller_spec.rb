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
  context "send a email" do
    after {ActionMailer::Base.deliveries.clear}
    before {ActionMailer::Base.deliveries.clear}
    it "sends a email with valid input" do
      post :create, user: {name: "Bob", password: "123456", email:"user@email.com"}
      expect(ActionMailer::Base.deliveries).not_to be_nil
    end
    it "sends a email to the right receiver with valid input" do
      post :create, user: {name: "Bob", password: "123456", email:"user@email.com"}
      expect(ActionMailer::Base.deliveries.last.to).to eq(["user@email.com"])
    end
    it "sends a email to the right context with valid input"  do
      post :create, user: {name: "Bob", password: "123456", email:"user@email.com"}
      expect(ActionMailer::Base.deliveries.last.body).to include("Welcome to MyFlix, Bob!")
    end
    it "doesnot send an email with invalid input" do
      post :create, user: {email:"John@email.com"}
      expect(ActionMailer::Base.deliveries).to eq([])
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

  describe "GET show" do
    let(:bob) {Fabricate(:user)}
    before do 
      set_current_user_alice
    end
    it "sets a variable @user" do
      get :show, id: bob.token
      expect(assigns(:user).name).to eq(bob.name)
    end
    it "renders show template" do
      get :show, id:bob.id
      expect(response).to render_template('users/show')
    end
    it "redirects a sign in page when unauthenticated user" do
      set_current_user_nil
      get :show, id:bob.id
      expect(response).to redirect_to sign_in_path
    end
  end

end