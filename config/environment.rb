
RAILS_GEM_VERSION = '2.3.10' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem "clearance", :version => '0.8.8'
  config.gem "paperclip", :version => '2.3.4'
  config.gem "aws-s3", :version => '0.6.2', :lib => "aws/s3"
  config.gem "jrails", :version => '0.6.0'
  config.gem "twitter", :version => '>= 0.9.8'
  config.gem "oauth", :version => '>= 0.4.1'
  config.gem "postageapp", :version => '1.0.8'

  config.time_zone = 'UTC'

end