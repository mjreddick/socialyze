class AddColumnTimeZoneToTwitterAccounts < ActiveRecord::Migration
  def change
    add_column :twitter_accounts, :time_zone, :string
  end
end
