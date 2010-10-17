class User < ActiveRecord::Base
  include Clearance::User
  acts_as_followable
  acts_as_follower
  acts_as_favorite_user
  
  has_many :musts, :dependent => :nullify
  has_many :comments, :dependent => :nullify
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  
  validates_format_of :username, :with => /^[a-z][\w\-]+$/i, :message => "cannot contain special characters or spaces"
  validates_exclusion_of :username, :in => %w( support blog www billing help api dev test production prod staging qa stage docs samples koombea examples status account doc docs), :message => "is not available"
  validates_length_of :username, :maximum => 20
  
  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  has_attached_file :avatar,
    :styles => {
      :tiny => "35x35",
      :preview => "175x175",
      :large => "300x300"
    }, 
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :path => "/uploads/avatars/:attachment/:id/:style.:extension",
    :bucket => AMAZON_S3['bucket']
<<<<<<< HEAD
  
=======

  def post_to_facebook(content)
    feed_content = content.is_a?(Must) ? must.to_facebook_feed : content.to_s
    MustShare.post_to_facebook(self.fb_access_token, feed_content)
  end

  def post_to_twitter(content)
    tweet = content.is_a?(Must) ? must.to_tweet : content.to_s
    MustShare.post_to_twitter(self.twitter_client, tweet)
  end

  # I'm not sure if this method should be private
  def twitter_client
    oauth = Twitter::OAuth.new(TWITTER_AUTH['key'], TWITTER_AUTH['secret'])
    oauth.authorize_from_access(self.access_token, self.access_secret)

    client = Twitter::Base.new(oauth)
    client
  end
>>>>>>> 2354be1bbe6fc92964843e342b7534bc24f174aa
end
