require_relative 'board'
class Game

  def initialize(size)
    @board = Board.new(size)
  end

  def play
    @board.setup
    @board.show_adjacent_tiles([5,5])
    @board.render
  end


end

game = Game.new(9)
game.play
