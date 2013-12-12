REQUIRED_KEYS = %w{AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY FOG_DIRECTORY}
REQUIRED_KEYS.each do |key|
  throw "Required key #{key} missing" unless ENV[key]
end

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider              => "AWS",
    :aws_access_key_id     => ENV["AWS_ACCESS_KEY_ID"],
    :aws_secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"],
    :region                => ENV["S3_REGION"],
    :host                  => ENV["S3_HOST"]
  }

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads" # For Heroku
  config.fog_directory = ENV["FOG_DIRECTORY"]
end