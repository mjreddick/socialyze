class ChangeOwnerAndFollowerColumnNamesInTwitterFollwers < ActiveRecord::Migration
  def change
    rename_column :twitter_followers, :owner, :owner_id
    rename_column :twitter_followers, :follower, :follower_id
  end
end
