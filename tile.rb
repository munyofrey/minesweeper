class Tile

  attr_accessor :value

  def initialize
    @mine = false
    @flipped = false
  end

  def make_mine
    @mine = true
  end

  def to_s
    return "|_| " unless @flipped
    return "|*|" if @mine
    return "|_|" unless @mine
  end

  def flipped?
    @flipped
  end

  def show
    @flipped = true
  end

  def is_mine?
    @mine
  end

end
