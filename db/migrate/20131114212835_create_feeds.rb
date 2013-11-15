class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :uri, null: false

      t.timestamps
    end
  end
end
