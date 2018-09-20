load 'CanvasCommand.rb'
load 'ProgramCommand.rb'

class InputInterface

  def read_command
    command_expression = gets.chomp
    Gem.win_platform? ? (system "cls") : (system "clear")
    create_command command_array: command_expression.split
  end

  protected

  def create_command command_array:
    unless command_array.nil?
      case command_array[0]
      when 'Q'
        unless command_array.length != 1
          return ProgramCommand.new command: {order: command_array[0]}
        end
      when 'H'
        unless command_array.length != 1
          return ProgramCommand.new command: {order: command_array[0]}
        end
      when 'C'
        unless command_array.length != 3
          return ProgramCommand.new command: {order: command_array[0], data: command_array[1..2].map{|x| x.to_i}}
        end
      when 'B'
        if command_array.length == 4
          return CanvasCommand.new command: {order: command_array[0], data: command_array[1..2].map{|x| x.to_i}.push(command_array[3])}
        elsif command_array.length == 3
          return CanvasCommand.new command: {order: command_array[0], data: command_array[1..2].map{|x| x.to_i}.push(' ')}
        end
      when 'L'
        unless command_array.length != 5
          return CanvasCommand.new command: {order: command_array[0], data: command_array[1..4].map{|x| x.to_i}}
        end
      when 'R'
        unless command_array.length != 5
          return CanvasCommand.new command: {order: command_array[0], data: command_array[1..4].map{|x| x.to_i}}
        end
      end
    end
  end
end
