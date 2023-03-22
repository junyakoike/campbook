class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.string :name
      t.text :chara
      t.text :access
      t.integer :user_id

      t.timestamps
    end
  end
end
