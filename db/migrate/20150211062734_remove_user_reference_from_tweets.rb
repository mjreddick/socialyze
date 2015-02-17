class RemoveUserReferenceFromTweets < ActiveRecord::Migration
  def change
    remove_reference :tweets, :user, index: true
  end
end
