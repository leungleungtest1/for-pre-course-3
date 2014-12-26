module StripeWrapper 
  class Charge
    @@total_number_of_charge = 0
    attr_reader :response, :status
    def initialize(response, status)
      @response = response
      @status = status
      @@total_number_of_charge += 1
    end

    def self.create(options={})
      StripeWrapper.set_api_key
      begin 
        response = Stripe::Charge.create(:amount => options[:amount], :currency => "usd", :card => options[:card], :description => options[:description] )
        new(response, :success)
      rescue Stripe::CardError => e
        new(e, :error)
      end
    end

    def successful?
      self.status == :success
    end

    def error_message
      self.response.message
    end

    def self.count
      @@total_number_of_charge
    end
  end

  def self.set_api_key
    Stripe.api_key = Rails.env.production? ? ENV['STRIPE_LIVE_SECRET_KEY'] : "sk_test_g9KW02Qtqasrw6Iu9Vj59gMm"
  end
end