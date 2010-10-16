TWITTER_AUTH = YAML.load_file("#{RAILS_ROOT}/config/twitter.yml")[RAILS_ENV]
FACEBOOK = YAML.load_file("#{RAILS_ROOT}/config/facebook.yml")[RAILS_ENV]
ZENCODER = YAML.load_file("#{RAILS_ROOT}/config/zencoder.yml")[RAILS_ENV]
POSTAGEAPP = YAML.load_file("#{RAILS_ROOT}/config/postageapp.yml")[RAILS_ENV]