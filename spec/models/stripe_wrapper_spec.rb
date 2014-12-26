require 'spec_helper'

describe StripeWrapper do
  describe StripeWrapper::Charge do
    before do
      StripeWrapper.set_api_key
    end
    let(:token) do
     Stripe::Token.create(
                :card => { 
                :number => card_number,
                :exp_month => 12,
                :exp_year => 2016,
                :cvc => "314" }).id
                end
    context "with valid card" do
      let(:card_number) { "4242424242424242" }
      it "charges the card successfully.",:vcr do
        response = StripeWrapper::Charge.create(amount: 300, card: token, description: "test for stripe wrapper" ) 
        response.should be_successful
      end
    end
    context "with invalid card" do
      let(:card_number) {"4000000000000002"}
      let(:response) { StripeWrapper::Charge.create(amount: 300, card: token, description: "test for stripe wrapper" )} 
      it "does not charge the card successfully",:vcr do
        expect(response).not_to be_successful
      end
      it "returns a error message", :vcr do
        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end
end