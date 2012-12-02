class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :event_date
      t.text :description
      t.integer :thumbup
      t.integer :thumbdown
      t.integer :club_id

      t.timestamps
    end
    add_index :events, [:club_id, :created_at]
  end
end
