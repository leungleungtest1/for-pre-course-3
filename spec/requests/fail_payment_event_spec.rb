require 'spec_helper'

describe "Receive a fail payment message" do
  let(:event_data)  {{
  "id"=> "evt_15FcWJCP7OfzzeMeIzq4GFxE",
  "created"=> 1419994055,
  "livemode"=> false,
  "type"=> "charge.failed",
  "data"=> {
    "object"=> {
      "id"=> "ch_15FcWJCP7OfzzeMe9eitVqmR",
      "object"=> "charge",
      "created"=> 1419994055,
      "livemode"=> false,
      "paid"=> false,
      "amount"=> 999,
      "currency"=> "usd",
      "refunded"=> false,
      "captured"=> false,
      "card"=> {
        "id"=> "card_15FcVgCP7OfzzeMexA2WqTqP",
        "object"=> "card",
        "last4"=> "0341",
        "brand"=> "Visa",
        "funding"=> "credit",
        "exp_month"=> 12,
        "exp_year"=> 2017,
        "fingerprint"=> "rUvyIrRvEknaqDQC",
        "country"=> "US",
        "name"=> nil,
        "address_line1"=> nil,
        "address_line2"=> nil,
        "address_city"=> nil,
        "address_state"=> nil,
        "address_zip"=> nil,
        "address_country"=> nil,
        "cvc_check"=> "pass",
        "address_line1_check"=> nil,
        "address_zip_check"=> nil,
        "dynamic_last4"=> nil,
        "customer"=> "cus_5Q5lgTVu9EunsT"
      },
      "balance_transaction"=> nil,
      "failure_message"=> "Your card was declined.",
      "failure_code"=> "card_declined",
      "amount_refunded"=> 0,
      "customer"=> "cus_5Q5lgTVu9EunsT",
      "invoice"=> nil,
      "description"=> "testing for fiail charge",
      "dispute"=> nil,
      "metadata"=> {
      },
      "statement_descriptor"=> nil,
      "fraud_details"=> {
      },
      "receipt_email"=> nil,
      "receipt_number"=> nil,
      "shipping"=> nil,
      "refunds"=> {
        "object"=> "list",
        "total_count"=> 0,
        "has_more"=> false,
        "url"=> "/v1/charges/ch_15FcWJCP7OfzzeMe9eitVqmR/refunds",
        "data"=> []
      }
    }
  },
  "object"=> "event",
  "pending_webhooks"=> 3,
  "request"=> "iar_5QTT4aC36cSXoS",
  "api_version"=> "2014-12-17"
}}

  it "creates payment record", :vcr do
    bob = Fabricate(:user, customer_token: "cus_5Q5lgTVu9EunsT")
    post '/userpaymentrecord', event_data
    expect(Payment.count).to eq(1)
  end 
  it "creates payment record related to user id", :vcr do
    bob = Fabricate(:user, customer_token: "cus_5Q5lgTVu9EunsT")
    post '/userpaymentrecord', event_data
    expect(Payment.last.user_id).to eq(bob.id)
  end
  it "craetes payment record with status of failed", :vcr do
    bob = Fabricate(:user, customer_token: "cus_5Q5lgTVu9EunsT")
    post '/userpaymentrecord', event_data
    expect(Payment.last.status).to eq("failed")    
  end
  it "locks users from entering the website" do
    "This is a repsonsiblity of session controller"
  end
end