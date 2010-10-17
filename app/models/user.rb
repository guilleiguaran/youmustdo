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
  
  has_many :buckets
  
  validates_format_of :username, :with => /^[a-z][\w\-]+$/i, :message => "cannot contain special characters or spaces"
  validates_exclusion_of :username, :in => %w( support blog www billing help api dev test production prod staging qa stage docs samples koombea examples status account doc docs), :message => "is not available"
  validates_length_of :username, :maximum => 20
  
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
  
  def bucket_list_count
    self.buckets.find(:all, :conditions => {:status => true}).count
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
