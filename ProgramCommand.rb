class ProgramCommand

  def self.make_new command_data:
    order = command_data[:order]
    data = ProgramCommand.make_data(type: order, data: command_data[:data])
    if ProgramCommand.valid_command?(order: order, data: data)
       return ProgramCommand.new command: {order: order, data: data}
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

  def self.make_data type:, data:
    if type == 'C'
      x = data[0]
      y = data[1]
      return Canvas.make_new size: Point.make_new(x: x, y: y)
    else
      return type
    end
  end

  def self.valid_command? order:, data:
    if order == 'C' or order == 'Q' or order == 'H' or order == 'W'
      return !data.nil?
    end
  end
end
