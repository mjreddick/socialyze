class RemoveColumnUserIdIdToTwitterResult < ActiveRecord::Migration
  def change
    remove_column :twitter_results, :user_id_id
  end
end
