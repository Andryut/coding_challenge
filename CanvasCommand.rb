class CanvasCommand
  def initialize command:
    @order = command[:order]
    @data = command[:data]
  end

  def command
    {order: @order, data: @data}
  end

  def is_b?
    @order == 'B'
  end

  def is_r?
    @order == 'R'
  end

  def is_l?
    @order == 'L'
  end

  def x_1
    @data[0]
  end

  def y_1
    @data[1]
  end

  def x_2
    @data[2]
  end

  def y_2
    @data[3]
  end

  def c
    @data[2]
  end

  def valid_command? canvas:
    valid = false
    if @order == 'B'
      valid = (@data[0].is_a?(Numeric) and
              @data[1].is_a?(Numeric) and
              canvas.valid_color_place?(x: @data[0], y: @data[1]))
    elsif @order == 'R'
      valid = (@data[0].is_a?(Numeric) and
              @data[1].is_a?(Numeric) and
              @data[2].is_a?(Numeric) and
              @data[3].is_a?(Numeric) and
              canvas.coordinate_in_canvas?(x: @data[0], y: @data[1]) and
              canvas.coordinate_in_canvas?(x: @data[2], y: @data[3]))
    elsif @order == 'L'
      valid = (@data[0].is_a?(Numeric) and
              @data[1].is_a?(Numeric) and
              @data[2].is_a?(Numeric) and
              @data[3].is_a?(Numeric) and
              (@data[0] == @data[2] or @data[1] == @data[3]) and
              canvas.coordinate_in_canvas?(x: @data[0], y: @data[1]) and
              canvas.coordinate_in_canvas?(x: @data[2], y: @data[3]))
    end
    return valid
  end
end
