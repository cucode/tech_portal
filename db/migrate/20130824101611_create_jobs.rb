class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.datetime :listed
      t.text :description
      t.string :url

      t.timestamps
    end
  end
end
