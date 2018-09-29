class ColorCoordinate

  attr_reader :point
  attr_reader :color

  def self.make_new point:, color:
    unless point.nil?
      if color.nil?
        color = ' '
      end
      return ColorCoordinate.new(point: point, color: color)
    end
  end

  protected

  def initialize point:, color:
    @point = point
    @color = color
  end
end
