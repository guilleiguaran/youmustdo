class User < ActiveRecord::Base
  include Clearance::User
  acts_as_followable
  acts_as_follower
  
  has_many :musts, :dependent => :destroy
  has_many :comments
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  
  validates_format_of :username, :with => /^[a-z][\w\-]+$/i, :message => "cannot contain special characters or spaces"
  validates_exclusion_of :username, :in => %w( support blog www billing help api dev test production prod staging qa stage docs samples koombea examples status account doc docs), :message => "is not available"
  validates_length_of :username, :maximum => 20
  
  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  has_attached_file :photo,
    :styles => {
      :tiny => "35x35",
      :preview => "175x175",
      :large => "300x300"
    }, 
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :path => "/uploads/avatars/:attachment/:id/:style.:extension",
    :bucket => AMAZON_S3['bucket']
    
end
