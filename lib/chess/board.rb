require 'singleton'

class Board
  include Singleton
  attr_accessor :columns
  
  WHITE_COLOR = 'white'.freeze
  BLACK_COLOR = 'black'.freeze
  
  def initialize
    @columns = []
  	initialize_board
  end

  private

  def initialize_board
  	(0..7).each do |x_pos| 
  	  (0..7).each do |y_pos|
        color = y_pos == 0 || (y_pos % 2) == 0 ? BLACK_COLOR : WHITE_COLOR

  	  	columns << Column.new(
          x_position: x_pos,
          y_position: y_pos,
          color: color
        )
  	  end
  	end
  end

  def self.valid_cell?(x, y)
    instance.columns.any? { |c| c.x_position == x && c.y_position == y }
  end
end
