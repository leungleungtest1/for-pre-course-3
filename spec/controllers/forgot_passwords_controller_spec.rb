require 'spec_helper'

describe ForgotPasswordsController do
  describe "GET new" do
    it "should render a tamplet new." do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "create a variable to check" do
      alice = Fabricate(:user, name: "alice" ,email: "alice@email.com") 
      post :create, email: "alice@email.com"
      expect(assigns(:email)).to eq("alice@email.com")
    end
    context " with exist and valid email address" do
      before do
        alice = Fabricate(:user, name: "alice" ,email: "alice@email.com")  
      end
      before do
        ActionMailer::Base.deliveries = []
      end
      it "sends a mailer to the eamil address" do
        post :create, email: "alice@email.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["alice@email.com"]) 
      end
      it "the email contain a link to reset" do
        post :create, email: "alice@email.com"
        expect(ActionMailer::Base.deliveries.last.body).to include("link to reset") 
      end
      it "redirect a page to tell user check email" do
        post :create, email: "alice@email.com"
        expect(response).to redirect_to forgot_password_confirmation_path
      end
    end
    context " with invalid email address" do
      alice = Fabricate(:user, name: "alice" ,email: "alice@email.com") 
      before do
        ActionMailer::Base.deliveries = []
      end
      it " does not sends a email" do
        post :create, email: "no_one@email.com"
        expect(ActionMailer::Base.deliveries).to eq([])
      end
      it "redirect to forgot password page to say there are something wrong in your email" do
        post :create, email: ""
        expect(response).to redirect_to forgot_password_path
        expect(flash[:danger]).not_to be_nil
      end
    end
  end
end