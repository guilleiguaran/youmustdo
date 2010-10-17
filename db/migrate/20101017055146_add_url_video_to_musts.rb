class AddUrlVideoToMusts < ActiveRecord::Migration
  def self.up
    add_column :musts, :url_video, :string
  end

  def self.down
    remove_column :musts, :url_video
  end
end
