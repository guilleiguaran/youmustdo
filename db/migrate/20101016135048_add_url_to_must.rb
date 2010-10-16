class AddUrlToMust < ActiveRecord::Migration
  def self.up
    add_column :musts, :url, :string
  end

  def self.down
    remove_column :musts, :url
  end
end
