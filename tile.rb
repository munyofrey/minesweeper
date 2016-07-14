class Tile

  attr_accessor :value

  attr_reader :pos

  def initialize(pos)
    @pos = pos
    @mine = false
    @flipped = false
    @flagged = false
  end

  def make_mine
    @mine = true
  end

  def to_s
    return "|f|" if @flagged
    return "|_|" unless @flipped
    return "|*|" if @mine
    @value ? "|#{value}|" : "|0|"
  end

  def flag
    @flagged = true
  end

  def flagged?
    @flagged
  end

  def flipped?
    @flipped
  end

  def show
    @flipped = true unless @flagged
  end

  def is_mine?
    @mine
  end

end
