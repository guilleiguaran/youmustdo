class User < ActiveRecord::Base
  include Clearance::User
  has_many :musts, :dependent => :destroy
  has_many :comments
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  
  validates_format_of :username, :with => /^[a-z][\w\-]+$/i, :message => "cannot contain special characters or spaces"
  validates_exclusion_of :username, :in => %w( support blog www billing help api dev test production prod staging qa stage docs samples koombea examples status account doc docs), :message => "is not available"
  validates_length_of :username, :maximum => 20
  
  validates_length_of :bio, :maximum => 256
  
end
