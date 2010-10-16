class CreateMust < ActiveRecord::Migration
def self.up
    create_table :musts do |t|
      t.string :name
      t.integer :user_id
      t.integer :category_id
      t.text :description
      t.string :location
      t.timestamps
    end
  end

  def self.down
    drop_table :musts
  end
end
