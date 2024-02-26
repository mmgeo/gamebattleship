class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.integer :gridsize
      t.integer :totalships
      t.string :p1ShipPositions
      t.string :p2shipPositions
      t.integer :totalMissiles
      t.string :p1moves
      t.string :p2moves

      t.timestamps
    end
  end
end
