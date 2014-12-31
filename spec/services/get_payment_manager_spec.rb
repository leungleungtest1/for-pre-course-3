require 'spec_helper'
describe GetPaymentManager do
  describe "#user_sign_up" do
    context "with valid user info and card" do
      before do
        customer = double('customer')
        customer.stub(:successful?).and_return(true)
        customer.stub(:customer_token).and_return("dke3d")
        StripeWrapper::Customer.stub(:create).and_return(customer)
      end
      it "stores the customer token from stripe" do
        budda = Fabricate(:user)
        budda.update_column(:token, "7890")
        bob = Fabricate(:user)
        GetPaymentManager.new(bob).user_sign_up(:token,budda)    
        expect(User.last.customer_token).to eq("dke3d")
      end
      it "creates a leadership and followership with invitor when @user is valid and there is invitor" do
        budda = Fabricate(:user)
        budda.update_column(:token, "7890")
        bob = Fabricate(:user)
        GetPaymentManager.new(bob).user_sign_up(:token,budda)
        expect(User.last.leaders).to include(budda)
        expect(User.last.followers).to include(budda)  
      end

      it " creates the invitor token to ensure one invitation only invites one user." do
        budda = Fabricate(:user)
        budda.update_column(:token, "7890")
        invitor=User.find_by(token: "7890")
        bob = Fabricate(:user)
        terry = Fabricate(:user)
        GetPaymentManager.new(bob).user_sign_up(:token,invitor)
        invitor=User.find_by(token: "7890")
        GetPaymentManager.new(terry).user_sign_up(:token,invitor)
        expect(User.last.leaders).not_to include(budda)
      end
    end
    context "with valid personal info and invalid card"do
      before do
        customer = double('customer')
        customer.stub(:successful?).and_return(false)
        StripeWrapper::Customer.stub(:create).and_return(customer)
        customer.stub(:error_message).and_return("fail")
      end
      it "sets error_message" do
        bob = Fabricate(:user)
        getpaymentmanager = GetPaymentManager.new(bob)
        getpaymentmanager.user_sign_up("1s31")
        expect(getpaymentmanager.error_message).to be_present
      end
    end
    context "with invalid perosnal info" do
      before do
        customer = double('customer')
        customer.stub(:successful?).and_return(true)
        StripeWrapper::Customer.stub(:create).and_return(customer)
      end
      it "does not create a user" do
        bob = User.create(name: "sparta")
        getpaymentmanager = GetPaymentManager.new(bob)
        getpaymentmanager.user_sign_up("1s31")
        expect(User.count).to eq(0)
      end
      it "does not charge the card" do
        bob = User.create(name: "sparta")
        getpaymentmanager = GetPaymentManager.new(bob)
        getpaymentmanager.user_sign_up("1s31")
        StripeWrapper::Customer.should_not_receive(:create)
      end      
    end
    context "send a email" do
      before do
        customer = double('customer')
        customer.stub(:successful?).and_return(true)
        StripeWrapper::Customer.stub(:create).and_return(customer)
      end
      after {ActionMailer::Base.deliveries.clear}
      before {ActionMailer::Base.deliveries.clear}
      it "sends a email with valid input" do
        bob = Fabricate(:user)
        getpaymentmanager = GetPaymentManager.new(bob)
        getpaymentmanager.user_sign_up("1s31")
        expect(ActionMailer::Base.deliveries).not_to be_nil
      end
      it "sends a email to the right receiver with valid input" do
        bob = Fabricate(:user)
        getpaymentmanager = GetPaymentManager.new(bob)
        getpaymentmanager.user_sign_up("1s31")
        expect(ActionMailer::Base.deliveries.last.to).to eq(["#{bob.email}"])
      end
      it "sends a email to the right context with valid input"  do
        bob = Fabricate(:user)
        getpaymentmanager = GetPaymentManager.new(bob)
        getpaymentmanager.user_sign_up("1s31")
        expect(ActionMailer::Base.deliveries.last.body).to include("Welcome to MyFlix, #{bob.name}!")
      end
      it "doesnot send an email with invalid input" do
        bob = User.create(name: "sparta")
        getpaymentmanager = GetPaymentManager.new(bob)
        getpaymentmanager.user_sign_up("1s31")
        expect(ActionMailer::Base.deliveries).to eq([])
      end
    end
  end
end