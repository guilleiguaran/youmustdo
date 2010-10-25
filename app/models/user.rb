class User < ActiveRecord::Base
  include Clearance::User

  acts_as_followable
  acts_as_follower
  acts_as_favorite_user
  
  has_many :musts, :dependent => :nullify
  has_many :comments, :dependent => :nullify
  has_many :buckets
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :email  
  validates_format_of :username, :with => /^[a-z][\w\-]+$/i, :message => "cannot contain special characters or spaces"
  validates_exclusion_of :username, :in => %w( support blog www billing help api dev test production prod staging qa stage docs samples koombea examples status account doc docs), :message => "is not available"
  validates_length_of :username, :maximum => 20
  before_save :downcase_email
  
  has_attached_file :avatar,
    :styles => {
      :tiny => "35x35",
      :preview => "175x175",
      :large => "300x300"
    }, 
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "/uploads/avatars/:attachment/:id/:style.:extension",
    :bucket => AMAZON_S3['bucket']
    
  def self.authenticate(email, password)
    user = find_by_username(email) || find_by_email(email.to_s.downcase)
    user && user.authenticated?(password) ? user : nil
  end

  def post_to_facebook(content, must_url=nil)
    feed_content = content.is_a?(Must) ? content.to_facebook_feed : content.to_s
    MustShare.post_to_facebook(self.fb_access_token, feed_content, must_url)
  end

  def post_to_twitter(content, must_url=nil)
    tweet = content.is_a?(Must) ? content.to_tweet(must_url) : content.to_s
    MustShare.post_to_twitter(self.twitter_client, tweet)
  end
  
  def bucket_list_count
    self.buckets.find(:all, :conditions => {:status => false}).count
  end

  protected
  
  def twitter_client
    oauth = Twitter::OAuth.new(TWITTER_AUTH['key'], TWITTER_AUTH['secret'])
    oauth.authorize_from_access(self.access_token, self.access_secret)

    client = Twitter::Base.new(oauth)
    client
  end
  
  def downcase_email
    self.email = self.email.downcase
  end
  

  class << self
    def random_string(len)
      # This mehotd generates a random string consisting of characters and digits
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      string = ""
      1.upto(len) { |i| string << chars[rand(chars.size-1)] }
      chars = ("0".."9").to_a
      return string + chars[rand(chars.size-1)]
    end
  end
end
