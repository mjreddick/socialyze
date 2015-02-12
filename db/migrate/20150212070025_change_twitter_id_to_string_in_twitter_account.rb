class ChangeTwitterIdToStringInTwitterAccount < ActiveRecord::Migration
  def change
    change_column :twitter_accounts, :twitter_id, :string
  end
end
