require 'rails_helper'

RSpec.describe Pawn do
  describe '.initialize' do
    let(:x) { 0 }
    let(:y) { 2 }
    let(:color) { Pawn::WHITE_COLOR }
    let(:facing) { Pawn::NORTH }

    subject do
      Pawn.new(x_position: x, y_position: y, facing: facing, color: color)
    end

    it 'initialize a new square position on the board' do
      expect(subject.x_position).to eq(x)
      expect(subject.y_position).to eq(y)
      expect(subject.color).to eq(color)
      expect(subject.facing).to eq(facing)
    end
  end

  describe '#execute' do
    let!(:pawn) { Pawn.new }

    subject { pawn.execute(command) }

    context 'when invalid first command' do
      let(:command) { 'MOVE 2' }

      it 'does not execute the command' do
        subject
        expect(pawn.x_position).to be_nil
        expect(pawn.y_position).to be_nil
        expect(pawn.color).to be_nil
        expect(pawn.facing).to be_nil
      end
    end

    context 'when an invalid command' do
      let(:command) { 'PUSH 2' }

      it 'does not execute the command' do
        subject
        expect(pawn.x_position).to be_nil
        expect(pawn.y_position).to be_nil
        expect(pawn.color).to be_nil
        expect(pawn.facing).to be_nil
      end
    end

    context 'when a valid command' do
      describe '#place' do
        context 'when the command contains non existing position' do
          let(:command) { 'PLACE 1,8,EAST,BLACK' }

          it 'does not execute the command' do
            subject
            expect(pawn.x_position).to be_nil
            expect(pawn.y_position).to be_nil
            expect(pawn.color).to be_nil
            expect(pawn.facing).to be_nil
          end
        end

        context 'when a valid PLACE command' do
          let(:command) { 'PLACE 1,2,EAST,BLACK' }

          it 'executes the command' do
            subject
            expect(pawn.x_position).to eq(1)
            expect(pawn.y_position).to eq(2)
            expect(pawn.facing).to eq(Pawn::EAST)
            expect(pawn.color).to eq(Pawn::BLACK_COLOR)
          end
        end
      end

      describe '#move' do
        context 'when move command takes the pawn to a non existing position' do
          let(:place_command) { 'PLACE 7,6,EAST,BLACK' }
          let(:command) { 'MOVE 1' }
          let(:pawn) { Pawn.new }

          before do
            pawn.execute(place_command)
          end
          
          it 'does not execute the command, and the pawn position still the same' do
            subject
            expect(pawn.x_position).to eq(7)
            expect(pawn.y_position).to eq(6)
            expect(pawn.color).to eq(Pawn::BLACK_COLOR)
            expect(pawn.facing).to eq(Pawn::EAST)
          end
        end

        context 'when move command takes the pawn to an existing position' do
          let(:place_command) { 'PLACE 1,2,EAST,BLACK' }
          let(:pawn) { Pawn.new }
          let(:command) { 'MOVE 2' }

          before do
            pawn.execute(place_command)
          end
          
          it 'executes the command and moves the pawn' do
            subject
            expect(pawn.x_position).to eq(2)
            expect(pawn.y_position).to eq(2)
            expect(pawn.color).to eq(Pawn::BLACK_COLOR)
            expect(pawn.facing).to eq(Pawn::EAST)
          end
        end
      end

      describe '#left' do
        let(:place_command) { 'PLACE 1,2,EAST,BLACK' }
        let(:pawn) { Pawn.new }
        let(:command) { 'LEFT' }

        before do
          pawn.execute(place_command)
        end
        
        it 'changes the facing to left side of the pawn without changing position' do
          subject
          expect(pawn.x_position).to eq(1)
          expect(pawn.y_position).to eq(2)
          expect(pawn.color).to eq(Pawn::BLACK_COLOR)
          expect(pawn.facing).to eq(Pawn::NORTH)
        end
      end

      describe '#right' do
        let(:place_command) { 'PLACE 1,2,EAST,BLACK' }
        let(:pawn) { Pawn.new }
        let(:command) { 'RIGHT' }

        before do
          pawn.execute(place_command)
        end
        
        it 'changes the facing to right side of the pawn without changing position' do
          subject
          expect(pawn.x_position).to eq(1)
          expect(pawn.y_position).to eq(2)
          expect(pawn.color).to eq(Pawn::BLACK_COLOR)
          expect(pawn.facing).to eq(Pawn::SOUTH)
        end
      end

      describe '#report' do
        let(:place_command) { 'PLACE 1,2,EAST,BLACK' }
        let(:pawn) { Pawn.new }
        let(:command) { 'REPORT' }

        before do
          pawn.execute(place_command)
          pawn.execute('LEFT')
        end
        
        it 'reports the current position of the pawn' do
          expect(subject).to eq(pawn)
        end
      end
    end
  end
end
