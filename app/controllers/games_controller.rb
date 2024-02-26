# app/controllers/games_controller.rb
class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def upload
    File.open("output.txt", "w") do |file|
      # Redirect standard output to the file
      $stdout = file
  
    input_file = params[:input_file]
    if input_file
      input_data = input_file.read
      process_input(input_data)
      flash.now[:notice] =  "Input file uploaded successfully!"
    else
      flash.now[:alert] = "Please select a file to upload."
    end
 
    # Restore standard output
    $stdout = STDOUT

    @output_content = File.read("output.txt")

  end
end

  private

  def game_params
    params.require(:game).permit(:input_file)
  end

  def process_input(input_data)
    # Parse and process the input data here
    # For example, you can split the input lines and extract relevant information
    lines = input_data.split("\n")
    values = []
    gridsize = 0
    totalships = 0
    p1ShipPositions = 0 
    p2shipPositions = 0
    totalMissiles = 0
    # Process each line...
    lines.each_with_index do |line, index|
      # Process each line of input
      # Example: split the line by comma and assign values to variables
      values[index] = line
    end

    gridsize = values[0].to_i
    totalships = values[1].to_i
    p1ShipPositions =values[2].split(":")
    p2shipPositions = values[3].split(":")
    totalMissiles = values[4]
    p1moves = values[5].split(":")
    p2moves = values[6].split(":")
 

    puts "Player 1"

    player1hits = process_move("P1", p1ShipPositions, p2moves, gridsize)
    player2hits = process_move("P2", p2shipPositions, p1moves, gridsize)

    puts "P1  :  #{player1hits}"
    puts "P2  :  #{player2hits}"

    if player1hits == player2hits 
      puts "It is a draw"
    elsif player1hits > player2hits 
      puts "Player 1 wins"
    elseif player2hits > player1hits
      puts "player 2 wins"
    end

  end


  def process_move(player, shipPositions, moves, gridsize)

     hit = shipPositions & moves
     miss = moves-shipPositions

     alive = shipPositions - moves

     grid = ""

     # Print column indices
       # Print column indices
    col_indices = (0...gridsize).to_a.join(" ")
    grid << "   #{col_indices}\n"

    # Print rows with row indices and comparison
    gridsize.times do |row|
      row_content = "#{row}:"
      gridsize.times do |col|
        if hit.include?("#{row},#{col}")
          row_content << " X"
        elsif miss.include?("#{row},#{col}")
          row_content << " O"
        elsif alive.include?("#{row},#{col}")
          row_content << " B"
        else
          row_content << " _"
        end
      end
      grid << row_content + "\n"
    end

    puts grid

   return hit.size
   
  end


end
