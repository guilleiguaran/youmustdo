class Attachment < ActiveRecord::Base
  belongs_to :must

  has_attached_file :file,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/uploads/files/:attachment/:id/:style.:extension",
                    :bucket => AMAZON_S3['bucket']
end
