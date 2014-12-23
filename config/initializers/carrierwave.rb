CarrierWave.configure do |config|
  if Rails.env.staging? || Rails.env.production?
    config.storage = :fog
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => ENV["GMAIL_USERNAME"],                        # required
    :aws_secret_access_key  => ENV['GMAIL_PP'],                        # required
  }
  config.fog_directory  = 'leungleungmyflix'                          # required
  config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"} # optional, defaults to {}
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end