class Must < ActiveRecord::Base
    belongs_to :user
    validates_presence_of :name
    belongs_to :category
end