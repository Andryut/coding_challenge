load "Point.rb"
load "Line.rb"
load "Rectangle.rb"
load "ColorCoordinate.rb"

class CanvasCommand

  def self.make_new command_data:
    order = command_data[:order]
    data = command_data[:data]
    unless order.nil? or data.nil?
      geometric_object = CanvasCommand.create_geometric_object(type: order, data: data)
      if CanvasCommand.valid_command?(order: order, data: geometric_object)
         return CanvasCommand.new command: {order: order, data: geometric_object}
      end
    end
  end

  def execute
    @data
  end

  protected

  def initialize command:
    @order = command[:order]
    @data = command[:data]
  end

  def self.create_geometric_object type:, data:
    point_a = Point.make_new(x: data[0],y: data[1])
    point_b = Point.make_new(x: data[2],y: data[3])
    case type
    when 'L'
      return Line.make_new(point_a: point_a, point_b: point_b)
    when 'R'
      return Rectangle.make_new(point_a: point_a, point_b: point_b)
    when 'B'
      return ColorCoordinate.make_new(point: point_a, color: data[2])
    end
  end

  def self.valid_command? order:, data:
    if order == 'L' or order == 'R' or order == 'B'
      return !data.nil?
    end
  end
end
