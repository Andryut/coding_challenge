class ProgramCommand

  def initialize command:
    @order = command[:order]
    @data = command[:data]
  end

  def is_q?
    @order == 'Q'
  end

  def is_h?
    @order == 'H'
  end

  def is_c?
    @order == 'C'
  end

  def width
    @data[0]
  end

  def height
    @data[1]
  end

  def valid_command?
    valid = false
    if @order == 'Q' or @order == 'H'
      valid  = true
    elsif @order == 'C'
      unless @data.nil? or @data[0].nil? or @data[1].nil?
        valid = (@data[0].is_a?(Numeric) and
                @data[1].is_a?(Numeric) and
                @data[0] > 0 and
                @data[1] > 0)
      end
    end
    return valid
  end
end
