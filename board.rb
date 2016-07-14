require_relative 'tile'


class Board

  def initialize(size)
    @grid = Array.new(size) { Array.new(size) { Tile.new } }
    @mines = []
  end



  def size
    @grid.size
  end

  def setup
    place_mine until @mines.length == size
  end

  def show_adjacent_tiles(pos)
    self[pos].show
    adjacent_tiles(pos).each do |tile_pos|
      tile = self[pos]
      next if tile.nil?
      show_adjacent_tiles(pos)
    end
  end

  def adjacent_tiles(pos)
    x, y = pos
    [[x, y + 1],[x, y - 1],[x + 1, y],[x - 1, y]]
  end

  def place_mine
    pos = [rand(size), rand(size)]
    unless @mines.include?(pos)
      @mines << pos
      self[pos].make_mine
    end
  end

  def [](pos)
    x, y = pos
    return nil if @grid[x] = nil
    @grid[x][y]

  end

  def render
    @grid.each do |row|
      puts row.join
    end
  end

end
