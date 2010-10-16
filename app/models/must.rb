class Must < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :name
    belongs_to :category
    has_many :comments, :dependent => :destroy
    has_many :agrees, :dependent => :destroy
    after_create :agree_must
    

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
      return self.latitude + " - " + self.longitude 
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
end