class User < ActiveRecord::Base
  include Clearance::User
  has_many :musts, :dependent => :destroy
  has_many :comments
end
