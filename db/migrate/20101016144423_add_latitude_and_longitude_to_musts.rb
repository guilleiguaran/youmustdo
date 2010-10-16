class AddLatitudeAndLongitudeToMusts < ActiveRecord::Migration
  def self.up
    add_column :musts, :longitude, :string
    add_column :musts, :latitude, :string
    remove_column :musts, :location
    
  end

  def self.down
    add_column :musts, :location, :string
    remove_column :musts, :latitude
    remove_column :musts, :longitude
  end
end
