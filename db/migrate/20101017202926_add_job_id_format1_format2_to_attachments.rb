class AddJobIdFormat1Format2ToAttachments < ActiveRecord::Migration
  def self.up
    add_column :attachments, :job_id, :integer
    add_column :attachments, :format1_id, :integer
    add_column :attachments, :format2_id, :integer
    add_column :attachments, :format1_url, :string
    add_column :attachments, :format2_url, :string
    add_column :attachments, :format1_label, :string
    add_column :attachments, :format2_label, :string
  end

  def self.down
    remove_column :attachments, :format2_label
    remove_column :attachments, :format1_label
    remove_column :attachments, :format2_url
    remove_column :attachments, :format1_url
    remove_column :attachments, :format2_id
    remove_column :attachments, :format1_id
    remove_column :attachments, :job_id
  end
end
