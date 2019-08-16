  CarrierWave.configure do |config|
  config.storage    = :aws["flixterjcalicot"]
  config.aws_acl    = "public-read"

  config.aws_credentials = {
      access_key_id:     ENV["AWS_ACCESS_KEY"],
      secret_access_key: ENV["AWS_SECRET_KEY"],
      region:            ENV["us-east-2"]
  }
end


