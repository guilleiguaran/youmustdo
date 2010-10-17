
RAILS_GEM_VERSION = '2.3.10' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  config.gem "clearance", :version => '0.8.8'
  config.gem "paperclip", :version => '2.3.4'
  config.gem "aws-s3",    :version => '0.6.2', :lib => "aws/s3"
  config.gem "jrails",    :version => '0.6.0'
  config.gem "twitter",   :version => '>= 0.9.8'
  config.gem "oauth",     :version => '>= 0.4.1'
  config.gem "postageapp", :version => '1.0.8'

  # oauth2 and its dependencies
  #config.gem "addressable",     :version => '>= 2.2.2'
  #config.gem "multipart-post",  :version => '>= 1.0.1'
  config.gem "rack",      :version => '>= 1.2.1'
  config.gem "faraday",   :version => '>= 0.5.1'
  config.gem "oauth2",    :version => '>= 0.1.0'
  config.gem "will_paginate", :version => "2.3.15"
  config.gem "acts_as_favorite", :version => "0.1.2"
  config.gem "nokogiri", :version => '1.4.3.1'
  config.gem "typhoeus"

  config.gem 'whenever', :lib => false, :source => 'http://gems.github.com'
  config.gem 'aaronh-chronic', :lib => false

  config.time_zone = 'UTC'

  NO_REPLY = "no-reply@youmustdo.r10.railsrumble.com"
end