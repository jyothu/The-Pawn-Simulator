require 'rails_helper'

RSpec.describe Column do
  describe '.initialize' do
    let(:x) { 0 }
    let(:y) { 2 }
    let(:color) { Pawn::WHITE_COLOR }

    subject do
      Column.new(x_position: x, y_position: y, color: color)
    end

    it 'initialize a new square position on the board' do
      expect(subject.x_position).to eq(x)
      expect(subject.y_position).to eq(y)
      expect(subject.color).to eq(color)
    end
  end
end
