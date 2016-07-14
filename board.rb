require_relative 'tile'


class Board

  def initialize(size)
    @grid = []
    size.times do |x|
      row = []
      size.times do |y|
        row << Tile.new([x,y])
      end
      @grid << row
    end
    # @grid = Array.new(size) { Array.new(size) { Tile.new } }
    @mines = []
  end


  def size
    @grid.size
  end

  def setup
    place_mine until @mines.length == size
  end

  def show_adjacent_tiles(pos)
    return if self[pos].nil?
    # return if adjacent_tiles(pos).any?{|tile| self[tile].is_mine?}
    mine_count = adjacent_tiles(pos).inject(0) { |sum, pos| self[pos].is_mine? ? sum += 1 : sum  }
    self[pos].show
    self[pos].value = mine_count
    return if mine_count > 0
    adjacent_tiles(pos).each do |tile_pos|
      tile = self[tile_pos]
      next if tile.flipped?
      show_adjacent_tiles(tile_pos)
    end
  end

  def adjacent_tiles(pos)
    x, y = pos
    adj = [[x, y + 1],[x, y - 1],[x + 1, y],[x - 1, y]]
    adj.reject { |pos| self[pos].nil? || pos[0] < 0 || pos[1] < 0 }
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
    return nil if @grid[x] == nil
    @grid[x][y]
  end

  def won?
    unflipped = @grid.flatten.reject { |tile| tile.flipped? }.map(&:pos)
    unflipped.sort == @mines.sort
  end

  def render
    print "   "
    puts (0...size).to_a.join("  ")
    @grid.each_with_index do |row, index|
      print
      puts "#{index} #{row.join}"
    end
  end

  def save
    puts "name for your save"
    name = "saves/" + gets.chomp + ".yaml"
    File.write(name, self.to_yaml)
  end

end
