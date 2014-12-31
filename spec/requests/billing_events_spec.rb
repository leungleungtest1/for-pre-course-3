require 'spec_helper'

describe "Created payment on successful charge" do
  let(:event_data) { 
    {
  "id"=>  "evt_15FEYXCP7OfzzeMegZivdorX",
  "created"=>  1419901937,
  "livemode"=>  false,
  "type"=>  "charge.succeeded",
  "data"=>  {
    "object"=>  {
      "id"=>  "ch_15FEYWCP7OfzzeMe3oGMqOKD",
      "object"=>  "charge",
      "created"=>  1419901936,
      "livemode"=>  false,
      "paid"=>  true,
      "amount"=>  999,
      "currency"=>  "usd",
      "refunded"=>  false,
      "captured"=>  true,
      "card"=>  {
        "id"=>  "card_15FEYUCP7OfzzeMeQknRFQvl",
        "object"=>  "card",
        "last4"=>  "4242",
        "brand"=>  "Visa",
        "funding"=>  "credit",
        "exp_month"=>  12,
        "exp_year"=>  2017,
        "fingerprint"=>  "M9CveyNNxdxZBhBM",
        "country"=>  "US",
        "name"=>  nil,
        "address_line1"=>  nil,
        "address_line2"=>  nil,
        "address_city"=>  nil,
        "address_state"=>  nil,
        "address_zip"=>  nil,
        "address_country"=>  nil,
        "cvc_check"=>  "pass",
        "address_line1_check"=>  nil,
        "address_zip_check"=>  nil,
        "dynamic_last4"=>  nil,
        "customer"=>  "cus_5Q4h0J209Kxcqx"
      },
      "balance_transaction"=>  "txn_15FEYWCP7OfzzeMeHPMjEcEO",
      "failure_message"=>  nil,
      "failure_code"=>  nil,
      "amount_refunded"=>  0,
      "customer"=>  "cus_5Q4h0J209Kxcqx",
      "invoice"=>  "in_15FEYWCP7OfzzeMe2s2wkk2Z",
      "description"=>  nil,
      "dispute"=>  nil,
      "metadata"=>  {},
      "statement_descriptor"=>  nil,
      "fraud_details"=>  {},
      "receipt_email"=>  nil,
      "receipt_number"=>  nil,
      "shipping"=>  nil,
      "refunds"=>  {
        "object"=>  "list",
        "total_count"=>  0,
        "has_more"=>  false,
        "url"=>  "/v1/charges/ch_15FEYWCP7OfzzeMe3oGMqOKD/refunds",
        "data"=>  []
      }
    }
  },
  "object"=>  "event",
  "pending_webhooks"=>  1,
  "request"=>  "iar_5Q4hTbrp7zfuqN",
  "api_version"=>  "2014-12-17"
}
}
  it "creates a payment with the webmock from stripe for charge succeeded", :vcr do
    post '/userpaymentrecord', event_data
    expect(Payment.count).to eq(1)
  end

  it "create the payment associated with user", :vcr do
    alice = Fabricate(:user, customer_token: "cus_5Q4h0J209Kxcqx")
    post "/userpaymentrecord", event_data
    expect(Payment.first.user).to eq(alice)
  end
  it "create the payment with the amount",:vcr do
    post "/userpaymentrecord", event_data
    expect(Payment.first.amount).to eq(999)
  end
  it "create the payment with the reference_id",:vcr do
    post "/userpaymentrecord", event_data
    expect(Payment.first.reference_id).to eq("ch_15FEYWCP7OfzzeMe3oGMqOKD")
  end
end