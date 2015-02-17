class ChangeTwitterIdToTwitterUidInTwitterAccount < ActiveRecord::Migration
  def change
    rename_column :twitter_accounts, :twitter_id, :twitter_uid
  end
end
