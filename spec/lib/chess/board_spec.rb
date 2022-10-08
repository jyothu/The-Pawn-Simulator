require 'rails_helper'

RSpec.describe Board do
  describe '.initialize' do
    it 'initialize a new board with 64 squares' do
      board = Board.instance

      expect(board.columns.size).to eq(64)
    end
  end
end
