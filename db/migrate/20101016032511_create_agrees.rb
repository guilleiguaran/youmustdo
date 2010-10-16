class CreateAgrees < ActiveRecord::Migration
  def self.up
    create_table :agrees do |t|
      t.integer :user_id
      t.integer :must_id
      t.integer :calification

      t.timestamps
    end
  end

  def self.down
    drop_table :agrees
  end
end
