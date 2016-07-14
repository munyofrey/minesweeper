require_relative 'board'
class Game

  def initialize(size)
    @board = Board.new(size)
  end

  def play
    @board.setup
    until won?
      @board.render
      pos, flag = get_input
      if flag
        @board[pos].flag
      elsif @board[pos].flagged?
        puts "This position is flagged!"
      else
        return puts "You lose" if @board[pos].is_mine?
        @board.show_adjacent_tiles(pos)
      end
    end
    puts "You Win!"
  end

  def get_input
    puts "give me a position between 0 and #{@board.size}"
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
