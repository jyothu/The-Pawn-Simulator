class Pawn
	attr_accessor :x_position, :y_position, :color, :facing

  def initialize(x_position: x_position, y_position: y_position, color: color, facing: facing)
    @x_position = x_position
    @y_position = y_position
    @color = color
    @facing = facing
  end

  def move(command)
  end

end