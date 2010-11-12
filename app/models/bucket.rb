class Bucket < ActiveRecord::Base
  belongs_to :must
  belongs_to :user
  validates_uniqueness_of :must_id, :scope => [:user_id]
end