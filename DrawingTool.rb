load 'Canvas.rb'
load 'InputInterface.rb'

class DrawingTool

  def initialize
    @quit = false
    @states = {drawing: 0, help: 1, wrong_command: 2}
    @state = @states[:drawing]
    @input_interface = InputInterface.new
  end

  def launch
    Gem.win_platform? ? (system "cls") : (system "clear")
    until @quit
      self.log_state
      if self.drawing?
        self.draw command: @input_interface.read_command
      else
        @state = @states[:drawing]
      end
    end
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  protected

  def draw command:
    if valid_general_command command: command
      send_command command: command
      unless @canvas.nil?
        @canvas.draw
      else
        @state = @states[:wrong_command]
      end
    else
      @state = @states[:wrong_command]
    end
  end


  def valid_general_command command:
    valid = false
    if command.is_a? CanvasCommand
      valid = command.valid_command? canvas: @canvas
    elsif command.is_a? ProgramCommand
      valid = command.valid_command?
    end
    return valid
  end

  def log_state
    case @state
    when @states[:help]
      # To do
      puts 'some help ...'
    when @states[:drawing]
      print 'enter command: '
    when @states[:wrong_command]
      puts 'wrong command, H for help.'
    end
  end

  def drawing?
    @state == @states[:drawing]
  end

  def send_command command:
    if command.is_a? ProgramCommand
      self.execute_command command: command
    elsif command.is_a? CanvasCommand
      unless @canvas.nil?
        @canvas.execute_command(command: command)
      else
        @state = @states[:wrong_command]
      end
    end
  end

  def execute_command command:
    if command.is_q?
      @quit = true
    elsif command.is_h?
      @state = @states[:help]
    elsif command.is_c?
      @canvas = Canvas.new(width: command.width, height: command.height)
    end
  end
end
