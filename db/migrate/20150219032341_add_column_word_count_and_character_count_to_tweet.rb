class AddColumnWordCountAndCharacterCountToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :word_count, :integer
    add_column :tweets, :character_count, :integer
    add_column :tweets, :hour, :integer
  end
end
