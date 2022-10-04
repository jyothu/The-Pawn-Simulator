class Board
  attr_accessor :columns
  
  WHITE_COLOR = 'white'.freeze
  BLACK_COLOR = 'white'.freeze

  def initialize
  	initialize_board
  end

  private

  def initialize_board
  	(0..7).each do |x_pos| 
  	  (0..7).each do |y_pos|
  	  	columns << Column.new(
          x_position: x_pos,
          y_posistion: y_pos,
          color: y_pos % 2 == 0 ? BLACK_COLOR : WHITE_COLOR
        )
  	  end
  	end
  end
end