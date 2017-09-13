class PhotoUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
    'http://res.cloudinary.com/dawid4qiq/image/upload/v1494682181/news-logo-small_b61nx5.png'
  end

  # Create different versions of your uploaded files:
  version :small do
    process resize_to_fill: [70, 70]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
