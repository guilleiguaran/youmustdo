class Agree < ActiveRecord::Base
    belongs_to :must
    validates_uniqueness_of :must_id, :scope => :user_id
end
