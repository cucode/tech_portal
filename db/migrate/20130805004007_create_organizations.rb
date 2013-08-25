class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.text   :synopsis
      t.string :website
      t.string :email
      t.string :phone
      t.string :status, limit: 12, default: 'pending'
      t.string :slug
      t.string :submitter_name
      t.string :submitter_email
      t.string :submitter_phone

      t.timestamps
    end
  end
end
