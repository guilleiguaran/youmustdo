class Bucket < ActiveRecord::Base
  has_many :musts
  belongs_to :user
end