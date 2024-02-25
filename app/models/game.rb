# app/models/game.rb
class Game < ApplicationRecord
  serialize :player_1_board, Array
  serialize :player_2_board, Array
  serialize :player_1_ships, Array
  serialize :player_2_ships, Array

  before_create :initialize_boards, :initialize_ships

  def initialize_boards
    self.player_1_board = Array.new(10) { Array.new(10, :empty) }
    self.player_2_board = Array.new(10) { Array.new(10, :empty) }
  end

  def initialize_ships
    self.player_1_ships = []
    self.player_2_ships = []
  end

#   def player_1_ship_objects
#     player_1_ships.map { |ship_data| Ship.new(ship_data) }
#   end

#   def player_2_ship_objects
#     player_2_ships.map { |ship_data| Ship.new(ship_data) }
#   end

  def place_ship(player, ship, x, y, direction)
    board = player == 1 ? player_1_board : player_2_board
    ships = player == 1 ? player_1_ships : player_2_ships

    ship_positions = []

    case direction
    when 'horizontal'
      (0...ship.size).each do |i|
        return false if board[x][y + i] != :empty
        ship_positions << [x, y + i]
      end
    when 'vertical'
      (0...ship.size).each do |i|
        return false if board[x + i][y] != :empty
        ship_positions << [x + i, y]
      end
    end

    ship_positions.each do |pos|
      board[pos[0]][pos[1]] = ship.symbol
    end

    ships << ship

    save
  end

  def fire(player, x, y)
    opponent_board = player == 1 ? player_2_board : player_1_board
    opponent_ships = player == 1 ? player_2_ships : player_1_ships

    if opponent_board[x][y] != :empty
      opponent_board[x][y] = :hit
      opponent_ships.each do |ship|
        if ship.positions.include?([x, y])
          ship.hits << [x, y]
          return :hit
        end
      end
      return :sunk if opponent_ships.any? { |ship| ship.sunk? }
      :hit
    else
      opponent_board[x][y] = :miss
      :miss
    end
  end

  def game_over?
    
    player_1_ships.map { |ship_data| Ship.new(ship_data) }.all?(&:sunk?) || player_2_ships.map { |ship_data| Ship.new(ship_data) }.all?(&:sunk?)
  end
end
