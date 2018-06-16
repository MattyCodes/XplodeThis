require 'carrierwave/storage/fog'

if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
  end
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
      :region                 => 'us-east-2',
      :path_style             => true
    }

    config.storage          = :fog
    config.cache_dir        = "#{Rails.root}/tmp/uploads"
    config.fog_directory    = 'xplodethis'
    config.fog_attributes   = { 'Cache-Control'=>'max-age=315576000' }
  end
end
