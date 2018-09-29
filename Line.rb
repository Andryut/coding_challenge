class Line

  attr_reader :point_a
  attr_reader :point_b

  def self.make_new point_a:, point_b:
    unless point_a.nil? or point_b.nil?
      Line.new(point_a: point_a, point_b: point_b)
    end
  end

  protected

  def initialize point_a:, point_b:
    @point_a = point_a
    @point_b = point_b
  end
end
