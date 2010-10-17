class AddUrlImageToMusts < ActiveRecord::Migration
  def self.up
    add_column :musts, :url_image, :string
  end

  def self.down
    remove_column :musts, :url_image
  end
end
