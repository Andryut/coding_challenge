load 'Canvas.rb'
load 'InputInterface.rb'

class DrawingTool

  def initialize
    @quit = false
    @states = {running: 0, help: 1, wrong_command: 2}
    @state = @states[:running]
    @input_interface = InputInterface.new
  end

  def launch
    self.clean_screen
    until @quit
      self.log_state
      if self.running?
        self.run_this command: @input_interface.read_command
      else
        @state = @states[:running]
      end
    end
    self.clean_screen
  end

  protected

  def clean_screen
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def log_state
    case @state
    when @states[:wrong_command]
      puts 'wrong command, H for some help.'
    when @states[:running]
      print 'enter command: '
    when @states[:help]
      puts "C w h         Should create a new canvas of width w and height h.
L x1 y1 x2 y2 Should create a new line from (x1,y1) to (x2,y2). Currently only horizontal
              or vertical lines are supported. Horizontal and vertical lines will be drawn
              using the 'x' character.
R x1 y1 x2 y2 Should create a new rectangle, whose upper left corner is (x1,y1) and
              lower right corner is (x2,y2). Horizontal and vertical lines will be drawn
              using the 'x' character.
B x y c       Should fill the entire area connected to (x,y) with 'colour' c. The behaviour
              of this is the same as that of the 'bucket fill' tool in paint programs.
Q             Should quit the program."
    end
  end

  def running?
    @state == @states[:running]
  end

  def run_this command:
    if command.is_a? CanvasCommand
      self.draw command: command.execute
    elsif command.is_a? ProgramCommand
      self.execute command: command.execute
    end
    unless @canvas.nil?
      @canvas.draw
    end
  end

  def draw command:
    unless @canvas.nil?
      @canvas.execute command: command
    end
  end

  def execute command:
    if command.is_a? Canvas and @canvas.nil?
      @canvas = command
    elsif command == 'Q'
      @quit = true
    elsif command == 'H'
      @state = @states[:help]
    elsif command == 'W'
      @state = @states[:wrong_command]
    end
  end
end
