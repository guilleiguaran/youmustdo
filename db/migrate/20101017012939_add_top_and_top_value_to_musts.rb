class AddTopAndTopValueToMusts < ActiveRecord::Migration
  def self.up
    add_column :musts, :top, :boolean
    add_column :musts, :top_value, :float
  end

  def self.down
    remove_column :musts, :top
    remove_column :musts, :top_value
  end
end
