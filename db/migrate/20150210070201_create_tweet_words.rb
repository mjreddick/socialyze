class CreateTweetWords < ActiveRecord::Migration
  def change
    create_table :tweet_words do |t|
      t.string :word
      t.references :user, index: true
      t.references :tweet, index: true

      t.timestamps
    end
  end
end
