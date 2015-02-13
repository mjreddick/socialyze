class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.integer :twitter_id
      t.references :user, index: true
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
