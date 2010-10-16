class Must < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :name
    belongs_to :category
    has_many :comments, :dependent => :destroy
end