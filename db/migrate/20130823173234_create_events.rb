class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :group
      t.string :url
      t.datetime :time
      t.integer :duration
      t.text :description

      t.timestamps
    end
  end
end
