class Point

  attr_reader :x
  attr_reader :y

  def self.make_new x:, y:
    if valid_point?(x: x.to_i, y: y.to_i)
      return Point.new(x: x.to_i, y: y.to_i)
    end
  end

  def in_neighborhood? sup_left:, inf_right:
    (sup_left.x <= @x and inf_right.x >= @x and sup_left.y <= @y and inf_right.x >= @y)
  end

  protected

  def self.valid_point? x:, y:
    (x != 0 and y != 0)
  end

  def initialize x:, y:
    @x = x
    @y = y
  end
end
