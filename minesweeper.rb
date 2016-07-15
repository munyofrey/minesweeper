#!/Users/appacademy/.rbenv/versions/2.3.1/lib/ruby

require_relative 'board'

require 'yaml'
class Game

  def initialize(board)
    @board = board
  end

  def play
    @board.setup
    until won?
      system "clear"
      @board.render
      pos, flag, saved = get_input
      return if saved
      next if pos[0] >= @board.size || pos[1] >= @board.size
      tile = @board[pos]
      if flag
        tile.flagged? ? tile.unflag : tile.flag
      elsif tile.flagged?
        puts "This position is flagged!"
      elsif tile.is_mine?
         system "clear"
         @board.show_mines
         @board.render
         puts "You lose"
         return
      else
        @board.show_adjacent_tiles(pos)
      end
    end
    puts "You Win!"
  end

  def get_input
    puts "give me a position between 0 and #{@board.size - 1}, add an f to flag or to unflag or s to save game"
    parse_input(gets.chomp)
  end

  def parse_input(string)
    if string.include?("s")
      @board.save
      saved = true
    end
    flag=string.include?("f")
    pos = string.delete("f").strip.split(",").map(&:to_i)
    [pos,flag, saved]
  end

  def won?
    @board.won?
  end


end


if __FILE__ == $PROGRAM_NAME
  system "clear"
  puts "Would you like to load a game (y/n)"
  response = gets.chomp
  if response == "y"
    system "clear"
    puts "Possible saves"
    puts Dir.entries("saves").reject { |name| name == "." || name == ".." || name == ".gitignore" }.map { |name| name[0..-6] }.join(" ")
    puts "enter file name"
    file_name = gets.chomp + ".yaml"
    old_game = File.read("saves/" + file_name)
    board = YAML.load(old_game)
  else
    puts "Give me the size of the board (9 for a 9x9 grid)"
    size = gets.chomp.to_i
    puts "What is your desired number of mines?"
    num = gets.chomp.to_i
    board = Board.new(size,num)
  end
  system "clear"


  game = Game.new(board)
  game.play
end
