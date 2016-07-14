require 'colorized_string'

class Tile

  COLORS = {
    0 => :black,
    1 => :blue,
    2 => :green,
    3 => :red,
    4 => :blue
  }

  FLAG = "|\u2691|"

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
    return color(FLAG.encode('utf-8'), :red) if @flagged
    return "|_|" unless @flipped
    return "|*|" if @mine
    value > 0 ? color("|#{value}|", COLORS[value]) : color("|_|", :light_black)
  end

  def color(string, color = :white)
    ColorizedString[string].colorize(color)

  end

  def flag
    @flagged = true
  end

  def unflag
    @flagged = false
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
