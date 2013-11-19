class OrganizationsHaveManyFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :organization_id, :integer
  end
end
