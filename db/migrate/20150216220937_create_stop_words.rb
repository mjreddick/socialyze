class CreateStopWords < ActiveRecord::Migration
  def change
    create_table :stop_words do |t|
      t.string :word

      t.timestamps
    end
    add_index :stop_words, :word
  end
end
