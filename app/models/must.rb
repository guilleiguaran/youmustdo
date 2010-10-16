class Must < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :name
    belongs_to :category
    has_many :comments, :dependent => :destroy
    has_many :agrees, :dependent => :destroy
    
    def total_agrees
      self.agrees.find(:all, :conditions => {:calification => 1}).count
    end
    
    def total_disagrees
      self.agrees.find(:all, :conditions => {:calification => 0}).count
    end
    
    def location
      return self.latitude + " - " + self.longitude 
    end
end