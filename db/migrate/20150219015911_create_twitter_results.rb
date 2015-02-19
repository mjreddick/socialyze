class CreateTwitterResults < ActiveRecord::Migration
  def change
    create_table :twitter_results do |t|

      t.timestamps
    end
  end
end
