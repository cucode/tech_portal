class EventsBelongToFeeds < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.references :feed
    end
  end

  def self.down
    change_table :events do |t|
      t.remove :feed_id
    end
  end
end
