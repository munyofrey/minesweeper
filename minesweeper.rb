require_relative 'board'
class Game

  def initialize(size)
    @board = Board.new(size)
  end

  def play
    @board.setup
    until won?
      system "clear"
      @board.render
      pos, flag = get_input
      tile = @board[pos]
      if flag
        tile.flagged? ? tile.unflag : tile.flag
      elsif tile.flagged?
        puts "This position is flagged!"
      else
        return puts "You lose" if tile.is_mine?
        @board.show_adjacent_tiles(pos)
      end
    end
    puts "You Win!"
  end

  def get_input
    puts "give me a position between 0 and #{@board.size - 1}, add an f to flag or to unflag"
    parse_input(gets.chomp)
  end

  def parse_input(string)
    flag=string.include?("f")
    pos = string.delete("f").strip.split(",").map(&:to_i)
    [pos,flag]
  end

  def won?
    @board.won?
  end


end

game = Game.new(9)
game.play
