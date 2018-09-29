load 'CanvasCommand.rb'
load 'ProgramCommand.rb'

class InputInterface

  def read_command
    command_expression = gets.chomp
    self.clean_screen
    create_command command_array: command_expression.split
  end

  protected

  def clean_screen
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def create_command command_array:
    order = command_array[0]
    data = command_array[1..command_array.length - 1]
    command = ProgramCommand.make_new command_data: {order: order, data: data}
    if command.nil?
      command = CanvasCommand.make_new command_data: {order: order, data: data}
    end
    if command.nil?
      command = ProgramCommand.make_new command_data: {order: 'W', data: 'W'}
    end
    return command
  end
end
