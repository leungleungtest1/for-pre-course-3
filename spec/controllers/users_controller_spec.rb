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
    context "with valid personal info and valid card" do
      before do
        getpaymentmanager = double(:success)
        GetPaymentManager.stub(:new).and_return(getpaymentmanager)
        getpaymentmanager.should_receive(:user_sign_up).and_return(nil)
        getpaymentmanager.stub(:successful?).and_return(true)
      end
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
        expect(assigns(:user)).to be_instance_of(User)
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with valid personal info and invalid card" do
      before do
        getpaymentmanager = double('double')
        getpaymentmanager.stub(:successful?).and_return(false)
        getpaymentmanager.stub(:error_message).and_return("error_message
          ")
        GetPaymentManager.any_instance.should_receive(:user_sign_up)
      end
      it "set a variable @categories" do
        post :create, user: {name:"Bob", password: "123456", email:'user@email.com'}
        expect(assigns(:categories)).to eq(Category.all)
      end
      it "redirects to register page" do
        post :create, user: {name:"Bob", password: "123456", email:'user@email.com'}
        expect(response).to redirect_to register_path
      end
      it "sets the flash error message" do
        post :create, user: {name:"Bob", password: "123456", email:'user@email.com'}
        expect(flash[:danger]).to be_present
      end
    end
    context "invalid personal info" do
      before do
        getpaymentmanager = double('double')
        getpaymentmanager.stub(:successful?).and_return(false)
        getpaymentmanager.stub(:error_message).and_return("error_message
          ")
        GetPaymentManager.any_instance.should_receive(:user_sign_up)
      end
      it "redirects a register page when @user is not valid" do
        User.create(name: "Bob", password: "123456", email: "user1@email.com")
        post :create, user: {name: "Bob", password: "123456", email: "user1@email.com"}
        expect(response).to redirect_to register_path
      end
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