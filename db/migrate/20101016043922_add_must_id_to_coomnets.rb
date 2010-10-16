class AddMustIdToCoomnets < ActiveRecord::Migration
  def self.up
      add_column :comments, :must_id, :integer
  end

  def self.down
     remove_column :comments, :must_id
  end
end