require_relative 'board'
class Game

  def initialize(size)
    @board = Board.new(size)
  end

  def play
    @board.setup
    @board.render
  end


end

game = Game.new(9)
game.play
