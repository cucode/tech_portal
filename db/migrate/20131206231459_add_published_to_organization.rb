class AddPublishedToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :published, :boolean, default: false
    remove_column :organizations, :status, :string, limit: 12, default: 'pending'
  end
end
