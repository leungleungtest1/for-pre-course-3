Stripe.api_key = ENV['STRIPE_SECRET_KEY'] # Set your api key

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded' do |event|
    # Define subscriber behavior based on the event object
    event.data
    user_id = User.where(customer_token: event.data[:object][:customer]).first.id if User.find_by(customer_token: event.data[:object][:customer])
    amount = event.data[:object][:amount]
    reference_id = event.data[:object][:id]
    Payment.create(user_id: user_id, amount: amount, reference_id: reference_id)
  end

  events.subscribe 'charge.failed' do |event|
    user_id = User.where(customer_token: event.data[:object][:customer]).first.id if User.find_by(customer_token: event.data[:object][:customer])
    amount = event.data[:object][:amount]
    reference_id = event.data[:object][:id]
    Payment.create(user_id: user_id, amount: amount, reference_id: reference_id, status: "failed")
  end

end