class CreateTwitterFollowers < ActiveRecord::Migration
  def change
    create_table :twitter_followers do |t|
      t.integer :owner
      t.index :owner
      t.integer :follower
      t.index :follower
      
      t.timestamps
    end
  end
end
