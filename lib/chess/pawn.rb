class Pawn
	attr_accessor :x_position, :y_position, :color, :facing
  attr_reader :current_command

  def initialize(x_position: nil, y_position: nil, color: nil, facing: nil)
    @x_position = x_position
    @y_position = y_position
    @color = color
    @facing = facing
    @current_command = ''
  end

  private

  def execute(command)
    if valid_first_command?(command)
      PawnMoveLogger.logger.info("Command cannot be executed before placing the pawn.")
      return
    end

    @current_command = command
    
    unless valid_command?
      PawnMoveLogger.logger.debug("Invalid Command: `#{command}`")
      return
    end

    case command
    when command.match?(/PLACE/i)
      place
    when command.match?(/MOVE/i)
      move
    when command.match?(/LEFT/i)
      turn_left
    when command.match?(/RIGHT/i)
      turn_right
    when command.match?(/REPORT/i)
      report
    end
  end

  def place
    xpos, ypos, facing, color = current_command.gsub(/PLACE/i, '').strip.split(',')

    unless valid_cell?(xpos, ypos)
      PawnMoveLogger.logger.warn("#{command}`: Could not PLACE the pawn, Unknown position")
      return
    end
    
    pawn.x_position = xpos
    pawn.y_position = ypos
    pawn.color = color
  end

  def valid_first_command(command)
    command.blank? && !command.match?(/PLACE/i)
  end

  def valid_command?
    current_command.match?(/PLACE|MOVE|LEFT|RIGHT|REPORT/i)
  end
end


# ○ PLACE X,Y,F,C
# ○ MOVE X
# ○ LEFT
# ○ RIGHT
# ○ REPORT