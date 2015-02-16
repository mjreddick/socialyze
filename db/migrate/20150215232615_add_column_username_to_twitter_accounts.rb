class AddColumnUsernameToTwitterAccounts < ActiveRecord::Migration
  def change
    add_column :twitter_accounts, :username, :string
  end
end
