class Column
  attr_accessor :x_position, :y_position, :color, :piece

  def initialize(x_position:, y_position:, color: nil)
  	@x_position = x_position
  	@y_position = y_position
  	@color = color
  end
end
