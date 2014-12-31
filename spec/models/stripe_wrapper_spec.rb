require 'spec_helper'

describe StripeWrapper do
  let(:valid_token) do 
                Stripe::Token.create(
                :card => { 
                :number => "4242424242424242",
                :exp_month => 12,
                :exp_year => 2016,
                :cvc => "314" }).id
  end

  let(:declined_token) do 
                Stripe::Token.create(
                :card => { 
                :number => "4000000000000002",
                :exp_month => 12,
                :exp_year => 2016,
                :cvc => "314" }).id
  end  

  describe StripeWrapper::Charge do
    before do
      StripeWrapper.set_api_key
    end
    context "with valid card" do
      it "charges the card successfully.",:vcr do
        response = StripeWrapper::Charge.create(amount: 300, card: valid_token, description: "test for stripe wrapper" ) 
        response.should be_successful
      end
    end
    context "with invalid card" do
      let(:response) { StripeWrapper::Charge.create(amount: 300, card: declined_token, description: "test for stripe wrapper" )} 
      it "does not charge the card successfully",:vcr do
        expect(response).not_to be_successful
      end
      it "returns a error message", :vcr do
        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end

  describe StripeWrapper::Customer do
    describe ".create", :vcr do
      before do
      StripeWrapper.set_api_key
      end

      it "create a customer with valid card" do
        bob = Fabricate(:user)
        response = StripeWrapper::Customer.create(valid_token,bob)
        expect(response).to be_successful
      end
      it "returns the customer token for a valid card", :vcr do
        bob = Fabricate(:user)
        response = StripeWrapper::Customer.create(valid_token,bob)
        expect(response.customer_token).to be_present 
      end
      context "with declined card" do
         before do
          StripeWrapper.set_api_key
        end
        it "does not create a customer with declined card" do
          bob = Fabricate(:user)
        response = StripeWrapper::Customer.create(declined_token,bob)
        expect(response.error_message).to eq("Your card was declined.")
        expect(response).not_to be_successful
        end
      end
    end
  end
end