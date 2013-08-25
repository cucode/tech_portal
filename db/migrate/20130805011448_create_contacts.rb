class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :title
      t.string :email
      t.string :phone
      t.references :organization, index: true

      t.timestamps
    end
  end
end
