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

  #test for sending email in production
  config.action_mailer.default_url_options = {:host => 'peaceful-hollows-1925.herokuapp.com'}
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.smtp_settings = {
   :address => "smtp.gmail.com",
   :port => 465,
   :domain => 'peaceful-hollows-1925.herokuapp.com',  #I've also tried changing this to 'gmail.com'
   :authentication => :plain, # I've also tried changing this to :login
   :enable_starttls_auto => true,
   :user_name => 'leungleungtest2@gmail.com',
   :password => 'google123z'
 }
end
