class AddEventPhotoToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_photo, :string
  end
end
