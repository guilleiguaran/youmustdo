TWITTER_AUTH = YAML.load_file("#{RAILS_ROOT}/config/twitter.yml")[RAILS_ENV]
FACEBOOK = YAML.load_file("#{RAILS_ROOT}/config/facebook.yml")[RAILS_ENV]
ZENCODER = YAML.load_file("#{RAILS_ROOT}/config/zencoder.yml")[RAILS_ENV]
AMAZON_S3 = YAML.load_file("#{RAILS_ROOT}/config/s3.yml")[RAILS_ENV]