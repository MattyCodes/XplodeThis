class HeaderUploader < CarrierWave::Uploader::Base
  def store_dir
    "xplodethis/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
