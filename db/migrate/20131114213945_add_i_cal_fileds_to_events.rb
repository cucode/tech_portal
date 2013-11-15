class AddICalFiledsToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :duration, :integer
    rename_column :events, :title, :summary
    rename_column :events, :time,  :dtstart

    add_column :events, :dtend,    :datetime
    add_column :events, :dtstamp,  :datetime
    add_column :events, :location, :string
    add_column :events, :uid,      :string
  end
end
