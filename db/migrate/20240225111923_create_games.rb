class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.text :player_1_board
      t.text :player_2_board
      t.text :player_1_ships
      t.text :player_2_ships
      t.integer :current_player
      t.string :game_status

      t.timestamps
    end
  end
end
