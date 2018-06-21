class HeaderUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("default_avatar.png")
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
