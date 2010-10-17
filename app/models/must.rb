class Must < ActiveRecord::Base
  acts_as_favorite
  acts_as_taggable

  validates_presence_of :name

  belongs_to :user
  belongs_to :category

  has_one :attachment, :dependent => :destroy

  has_many :comments, :dependent => :destroy
  has_many :agrees, :dependent => :destroy

  after_create :agree_must, :should_process
  named_scope :by_creation_date, :order => "created_at DESC"

  def calification
    self.total_agrees - self.total_disagrees
  end

  def total_agrees
    self.agrees.sum(:calification, :conditions => ['calification = ?', 1])
  end

  def total_disagrees
    self.agrees.sum(:calification, :conditions => ['calification = ?', -1])
  end

  def agree_must
    agree = Agree.create(:must_id => self.id, :user_id => self.user.id, :calification => 1)
  end

  def location
    return self.latitude + " - " + self.longitude unless self.latitude.nil? or self.longitude.nil?
    return ""
  end
  
  def is_done(u)
      bucket = Bucket.find_by_user_id_and_must_id(u.id, self.id)
      unless bucket.nil?
        return bucket.status
      else
        return false
      end
  end

  def category_name
    self.category.name
  end

  def to_facebook_feed
    "Share with facebook: #{self.name}. http://youmustdo.com/"
  end

  def to_tweet
    short_url = UrlShortener.shorten(must_url)
    tweet = truncate("#{self.name}", :length => (139 - short_url.to_s.length))
    "#{tweet} #{short_url}"
  end

  class << self
    def refresh_top_musts
      # Must.all( :select => "*, DATEDIFF(NOW(), created_at) as top_factor",
      #           :conditions => ["created_at >= ?", Time.now - 7.days])

      # Let's find the top rated Musts
      top_factor_query = %{SELECT *, DATEDIFF(NOW(), created_at) AS top_factor FROM agrees WHERE created_at >= ?}
      top_musts = Agree.find_by_sql([%{
        SELECT must_id, COUNT(id) * ((7 - top_factor) / 7) AS top_value
        FROM (#{top_factor_query}) as top_factors
        GROUP BY must_id}, Time.now - 7.days])
        
      logger.info top_musts.inspect
      puts top_musts.inspect

      # Then we reset the previous Musts top rated
      Must.update_all ["top = ?", false], ["top = ?", true]

      # And finally, we update the top rated Musts and set their new top value
      top_musts.each do |must|
        Must.find_by_id(must.must_id).update_attributes({
          :top_value => must.top_value,
          :top => true
          })
      end
    end
  end

  def should_process
    case self.category.name.downcase
    when "listen" then zencoder_process_audio
    end
  end

  def attachment_format1_ready?
    response = Zencoder::Output.progress(self.attachment.format1_id)
    data = response.body.to_hash
    logger.info response.inspect
    puts response.inspect
    data['status'].eql?("finished")
  end

  def attachment_format2_ready?
    response = Zencoder::Output.progress(self.attachment.format2_id)
    data = response.body.to_hash
    logger.info response.inspect
    puts response.inspect
    data['status'].eql?("finished")
  end

  def zencoder_file_url(filename, ext)
    "s3://files.youmustdo.local/#{filename}.#{ext}"
  end

  def zencoder_process_audio
    response = Zencoder::Job.create({
      :input => self.attachment.file.url,
      :outputs => [
        {
          :label => zencoder_output_name("ogg"),
          :url => zencoder_file_url(zencoder_output_name, "ogg"),
          :audio_codec => "vorbis",
          :public => 1
        },
        {
          :label => zencoder_output_name("mp3"),
          :url => zencoder_file_url(zencoder_output_name, "mp3"),
          :audio_codec => "mp3",
          :public => 1
        }
      ]
    })
    data = response.body.to_hash
    self.attachment.update_attributes({
      :job_id => data['id'],
      :format1_id => data['outputs'][0]['id'],
      :format2_id => data['outputs'][1]['id'],
      :format1_url => data['outputs'][0]['url'],
      :format2_url => data['outputs'][1]['url'],
      :format1_url => data['outputs'][0]['label'],
      :format2_url => data['outputs'][1]['label']
    })
    logger.info response.inspect
    puts response.inspect
  end

  def zencoder_output_name(type="")
    "Must_#{self.id}_Attachment_#{self.attachment.id}_#{type}"
  end
end