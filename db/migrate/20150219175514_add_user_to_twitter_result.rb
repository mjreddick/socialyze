class AddUserToTwitterResult < ActiveRecord::Migration
  def change
    add_reference :twitter_results, :user, index: true
  end
end
