class AddAttachmentsFileToAttachment < ActiveRecord::Migration
  def self.up
    add_column :attachments, :file_file_name, :string
    add_column :attachments, :file_content_type, :string
    add_column :attachments, :file_file_size, :integer
    add_column :attachments, :file_updated_at, :datetime
    add_column :attachments, :must_id, :integer
  end

  def self.down
    remove_column :attachments, :file_file_name
    remove_column :attachments, :file_content_type
    remove_column :attachments, :file_file_size
    remove_column :attachments, :file_updated_at
    remove_column :attachments, :must_id
  end
end
