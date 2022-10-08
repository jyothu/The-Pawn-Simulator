class Column
  attr_reader :x_position, :y_position, :color
  attr_accessor :piece

  def initialize(x_position:, y_position:, color: nil)
  	@x_position = x_position
  	@y_position = y_position
  	@color = color
  end
end
