load 'MyMatrix.rb'

class Canvas

  def initialize width:, height:
    @width = width
    @height = height
    create_canvas_space(row_count: height, col_count: width)
  end

  def valid_color_place? x:, y:
    coordinate_in_canvas?(x: x, y: y) and @matrix[y, x] != 'x'
  end

  def coordinate_in_canvas? x:, y:
    x >= 1 and x <= @width and y >= 1 and y <= @height
  end

  def draw
    @matrix.print_matrix
  end

  def execute_command command:
    if command.is_b?
      color_space(x: command.x_1, y: command.y_1, c: command.c)
    elsif command.is_r?
      draw_rect(x_1: command.x_1, y_1: command.y_1, x_2: command.x_2, y_2: command.y_2)
    elsif command.is_l?
      draw_line(x_1: command.x_1, y_1: command.y_1, x_2: command.x_2, y_2: command.y_2)
    end
  end

  protected

  def create_canvas_space row_count:, col_count:
    @matrix = MyMatrix.build row_count + 2, col_count + 2 do ' ' end
    @matrix.fill_col(n: 0, element: '|')
    @matrix.fill_col(n: col_count + 1, element: '|')
    @matrix.fill_row(n: 0, element: '-')
    @matrix.fill_row(n: row_count + 1, element: '-')
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
    self.draw_horizontal_line(y: y_1, x_1: x_1, x_2: x_2)
    self.draw_horizontal_line(y: y_2, x_1: x_1, x_2: x_2)
    self.draw_vertical_line(x: x_1, y_1: y_1 + 1, y_2: y_2 - 1)
    self.draw_vertical_line(x: x_2, y_1: y_1 + 1, y_2: y_2 - 1)
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
