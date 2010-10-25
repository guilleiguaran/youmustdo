TWITTER_AUTH = YAML.load_file("#{Rails.root}/config/twitter.yml")[Rails.env]
FACEBOOK = YAML.load_file("#{Rails.root}/config/facebook.yml")[Rails.env]
ZENCODER = YAML.load_file("#{Rails.root}/config/zencoder.yml")[Rails.env]
AMAZON_S3 = YAML.load_file("#{Rails.root}/config/s3.yml")[Rails.env]

ENV['ZENCODER_API_KEY'] = ZENCODER['key']
