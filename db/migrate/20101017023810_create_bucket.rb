class CreateBucket < ActiveRecord::Migration
   def self.up
    create_table :buckets do |t|
      t.integer :user_id
      t.integer :must_id
      t.boolean :status, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :buckets
  end
end
