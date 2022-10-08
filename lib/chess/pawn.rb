class Pawn
  attr_reader :current_command, :is_already_moved, :x_position, :y_position, :color, :facing

  EAST = 'EAST'.freeze
  WEST = 'WEST'.freeze
  SOUTH = 'SOUTH'.freeze
  NORTH = 'NORTH'.freeze

  BLACK_COLOR = 'BLACK'.freeze
  WHITE_COLOR = 'WHITE'.freeze

  PLACE_COMMAND = 'PLACE'.freeze
  LEFT_COMMAND = 'LEFT'.freeze
  RIGHT_COMMAND = 'RIGHT'.freeze
  MOVE_COMMAND = 'MOVE'.freeze
  REPORT_COMMAND = 'REPORT'.freeze

  def initialize(x_position: nil, y_position: nil, color: nil, facing: nil)
    @x_position = x_position
    @y_position = y_position
    @color = color
    @facing = facing
    @current_command = ''
    @is_already_moved = false
  end

  def execute(command)
    PawnMoveLogger.logger.info("Running Command: #{command}")

    if invalid_first_command?(command)
      PawnMoveLogger.logger.warn("Command cannot be executed before placing the pawn")
      return
    end

    @current_command = command
    
    unless valid_command?
      PawnMoveLogger.logger.debug("Invalid Command: `#{command}`")
      return
    end

    case command_for
    when PLACE_COMMAND
      place
    when MOVE_COMMAND
      move
    when LEFT_COMMAND
      turn_left
    when RIGHT_COMMAND
      turn_right
    when REPORT_COMMAND
      report
    end
  end

  private

  def command_for
    current_command.split.first.strip
  end

  def place
    xpos, ypos, facing, color = current_command.gsub(/PLACE/i, '').strip.split(',')

    if already_placed?
      PawnMoveLogger.logger.warn("#{current_command}`: Pawn already placed at (#{x_position}, #{y_position})")
      return
    end

    unless Board.valid_cell?(xpos.to_i, ypos.to_i)
      PawnMoveLogger.logger.warn("#{current_command}`: Could not PLACE the pawn, Unknown position - (#{xpos}, #{ypos})")
      return
    end
    
    @x_position = xpos.to_i
    @y_position = ypos.to_i
    @facing = facing.upcase
    @color = color.upcase
  end

  def turn_left
    case facing
    when EAST
      @facing = NORTH
    when WEST
      @facing = SOUTH
    when NORTH
      @facing = WEST
    when SOUTH
      @facing = EAST
    end
  end

  def turn_right
    case facing
    when EAST
      @facing = SOUTH
    when WEST
      @facing = NORTH
    when NORTH
      @facing = EAST
    when SOUTH
      @facing = WEST
    end
  end

  #         WEST
  #          |
  # SOUTH----|-----NORTH
  #          |      
  #         EAST

  # 00 01 02 03 04 05 06 07
  # 10 11 12 13 14 15 16 17
  # 20 21 22 23 24 25 26 27
  # 30 31 32 33 34 35 36 37
  # 40 41 42 43 44 45 46 47
  # 50 51 52 53 54 55 56 57
  # 60 61 62 63 64 65 66 67
  # 70 71 72 73 74 75 76 77

  def move
    _, move_to = current_command.strip.split
    move_to = !is_already_moved && [0, 7].include?(x_position) ? move_to.to_i : 1

    new_x, new_y = determine_new_position(move_to)

    unless Board.valid_cell?(new_x, new_y)
      PawnMoveLogger.logger.warn("#{current_command}`: Could not move the pawn, Unknown position - (#{new_x}, #{new_y})")
      return
    end

    @is_already_moved = true
    @x_position = new_x
    @y_position = new_y
  end

  def report
    PawnMoveLogger.logger.info("FINAL POSITION: #{x_position}, #{y_position}, #{facing}, #{color}")
    self
  end

  def determine_new_position(move_to)
    case facing
    when EAST
      [@x_position + move_to, @y_position]
    when WEST
      [@x_position - move_to, @y_position]
    when NORTH
      [@x_position, @y_position + move_to]
    when SOUTH
      [@x_position, @y_position - move_to]
    end
  end

  def already_placed?
    x_position.present? && y_position.present?
  end

  def invalid_first_command?(command)
    current_command.blank? && !command.match?(/PLACE/i)
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