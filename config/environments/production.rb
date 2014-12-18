Myflix::Application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify
  #config.action_mailer.default_url_options = {host: 'peaceful-hollows-1925.herokuapp.com', :protocol => 'http'}
  
  #test for sending email in production
  config.action_mailer.default_url_options = {:host => 'peaceful-hollows-1925.herokuapp.com', :protocol => 'http'}
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp, {:address => "smtp.mailgun.com", :port => 587,:user_name => ENV["GMAIL_USERNAME"], :password => ENV['GMAIL_PP']}
  config.action_mailer.perform_deliveries = true
  config.action_mailer.smtp_settings = {
   :address => "smtp.mailgun.com",
   :port => 587,
   :domain => 'peaceful-hollows-1925.herokuapp.com', 
   :authentication => :plain, 
   :enable_starttls_auto => true,
   :user_name => ENV["GMAIL_USERNAME"],
   :password => ENV['GMAIL_PP']
  }
end
