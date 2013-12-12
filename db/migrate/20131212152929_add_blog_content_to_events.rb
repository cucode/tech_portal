class AddBlogContentToEvents < ActiveRecord::Migration
  def change
    add_column :events, :blog_content, :text
  end
end
