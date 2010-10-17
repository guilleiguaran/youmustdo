class Attachment < ActiveRecord::Base
  belongs_to :must

  has_attached_file :file,
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
                    :path => "/uploads/files/:attachment/:id/:style.:extension",
                    :bucket => AMAZON_S3['bucket']
end
