class Bucket < ActiveRecord::Base
  belongs_to :must
  belongs_to :user
end