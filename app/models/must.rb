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

        # Then we reset the previous Musts top rated
        Must.update_all ["top = ?", false], ["top = ?", true]

        # And finally, we update the top rated Musts and set their new top value
        top_musts.each do |must|
          Must.find_by_id(must.id).update_attributes({
            :top_value => must.top_value,
            :top => true
          })
        end
      end
    end
end