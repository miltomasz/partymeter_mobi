class SetDefaultThumbsValue < ActiveRecord::Migration
  def self.up
    change_column :events, :thumbup, :integer, :default => 0
    change_column :events, :thumbdown, :integer, :default => 0
    Event.update_all(["thumbup = ?", 0], ["thumbup IS NULL"])
    Event.update_all(["thumbdown = ?", 0], ["thumbdown IS NULL"])
  end

  def self.down
  	change_column :events, :thumbup, :integer, :default => nil
    change_column :events, :thumbdown, :integer, :default => nil
    Event.update_all(["thumbup = ?", nil], ["thumbup = ?", 0])
    Event.update_all(["thumbdown = ?", nil], ["thumbdown = ?", 0])
  end
end
