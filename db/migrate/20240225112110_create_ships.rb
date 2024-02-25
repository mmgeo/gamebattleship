class CreateShips < ActiveRecord::Migration[7.1]
  def change
    create_table :ships do |t|
      t.string :name
      t.integer :size
      t.string :symbol

      t.timestamps
    end
  end
end
