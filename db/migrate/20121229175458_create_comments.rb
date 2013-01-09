class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :event_id

      t.timestamps
    end
    add_index :comments, [:event_id, :created_at]
  end
end
