class ChangeOwnerToFolloweeInTwitterFollowerRelationships < ActiveRecord::Migration
  def change
    rename_column :twitter_follower_relationships, :owner_id, :followee_id
  end
end
