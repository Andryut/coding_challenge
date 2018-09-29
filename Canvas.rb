load 'MyMatrix.rb'

class Canvas

  def self.make_new size:
    unless size.nil?
      return Canvas.new(width: size.x, height: size.y)
    end
  end

  def draw
    @matrix.print_matrix
  end

  def execute command:
    if command.is_a? Line and self.valid_figure?(point_a: command.point_a, point_b: command.point_b)
      x_1 = command.point_a.x
      y_1 = command.point_a.y
      x_2 = command.point_b.x
      y_2 = command.point_b.y
      self.draw_line(x_1: x_1, y_1: y_1, x_2: x_2, y_2: y_2)
    elsif command.is_a? Rectangle and self.valid_figure?(point_a: command.point_a, point_b: command.point_b)
      x_1 = command.point_a.x
      y_1 = command.point_a.y
      x_2 = command.point_b.x
      y_2 = command.point_b.y
      self.draw_rect(x_1: x_1, y_1: y_1, x_2: x_2, y_2: y_2)
    elsif command.is_a? ColorCoordinate and self.valid_color_place?(point: command.point, color: command.color)
      x = command.point.x
      y = command.point.y
      c = command.color
      self.color_space(x: x, y: y, c: c)
    end
  end

  protected

  def initialize width:, height:
    @width = width
    @height = height
    create_canvas_space(row_count: height, col_count: width)
  end

  def create_canvas_space row_count:, col_count:
    @matrix = MyMatrix.build row_count + 2, col_count + 2 do ' ' end
    @matrix.fill_col(n: 0, element: '|')
    @matrix.fill_col(n: col_count + 1, element: '|')
    @matrix.fill_row(n: 0, element: '-')
    @matrix.fill_row(n: row_count + 1, element: '-')
  end

  def valid_figure? point_a:, point_b:
    coordinate_in_canvas? point: point_a and coordinate_in_canvas? point: point_b
  end

  def valid_color_place? point:, color:
    coordinate_in_canvas?(point: point) and @matrix[point.y, point.x] != 'x' and color != 'x'
  end

  def coordinate_in_canvas? point:
    point.x >= 1 and point.x <= @width and point.y >= 1 and point.y <= @height
  end

  def draw_line x_1:, y_1:, x_2:, y_2:
    if x_1 == x_2
      draw_vertical_line(x: x_1, y_1: y_1, y_2: y_2)
    elsif y_1 == y_2
      draw_horizontal_line(y: y_1, x_1: x_1, x_2: x_2)
    end
  end

  def draw_vertical_line x:, y_1:, y_2:
    (y_1..y_2).each do |i|
      @matrix.put_in(i: i, j: x, element: 'x')
    end
  end

  def draw_horizontal_line y:, x_1:, x_2:
    (x_1..x_2).each do |j|
      @matrix.put_in(i: y, j: j, element: 'x')
    end
  end

  def draw_rect x_1:, y_1:, x_2:, y_2:
    self.draw_line(x_1: x_1, y_1: y_1, x_2: x_2, y_2: y_1)
    self.draw_line(x_1: x_1, y_1: y_2, x_2: x_2, y_2: y_2)
    self.draw_line(x_1: x_1, y_1: y_1 + 1, x_2: x_1, y_2: y_2 - 1)
    self.draw_line(x_1: x_2, y_1: y_1 + 1, x_2: x_2, y_2: y_2 - 1)
  end

  def color_space x:, y:, c:
    aux = [{x: 0, y: 1},{x: 1, y: 0},{x: -1, y: 0},{x: 0, y: -1}]
    stack = Array.new
    stack.push({x: x, y: y})
    until stack.empty?
      theLast = stack.last()
      @matrix.put_in(i: theLast[:y], j: theLast[:x], element: c)
      stack.pop
      (0..3).each do |i|
        if @matrix[theLast[:y] + aux[i][:y], theLast[:x] + aux[i][:x]] != 'x' and
           @matrix[theLast[:y] + aux[i][:y], theLast[:x] + aux[i][:x]] != '-' and
           @matrix[theLast[:y] + aux[i][:y], theLast[:x] + aux[i][:x]] != '|' and
           @matrix[theLast[:y] + aux[i][:y], theLast[:x] + aux[i][:x]] != c
          stack.push({x: theLast[:x] + aux[i][:x], y: theLast[:y] + aux[i][:y]})
        end
      end
    end
  end
end
