class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :address
      t.text :description
      t.integer :city_id

      t.timestamps
    end
    add_index :clubs, [:city_id, :created_at]
  end
end
