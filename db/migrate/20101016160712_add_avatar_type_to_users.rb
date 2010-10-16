class AddAvatarTypeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :external_avatar_url, :string
    add_column :users, :avatar_type, :string
  end

  def self.down
    remove_column :external_avatar_url, :string
    remove_column :avatar_type, :string
  end
end
