class ChangeTwitterFollowerTableName < ActiveRecord::Migration
  def change
    rename_table :twitter_followers, :twitter_follower_relationships
  end
end
