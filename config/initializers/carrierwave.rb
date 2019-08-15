CarrierWave.configure do |config|
  config.storage    = :fog
  config.aws_bucket = ENV["flixterjcalicot"]
  config.aws_acl    = "public_read"

  config.aws_credentials = {
    access_key_id:     ENV["AKIASZV6FXWXLEIUOXJV"],        # required
    secret_access_key: ENV["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"],        # required
    region:            ENV["US East(N.Virgina"]
  }
end
