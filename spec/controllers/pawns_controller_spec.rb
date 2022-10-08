require 'rails_helper'

RSpec.describe PawnsController, type: :controller do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET log' do
    before do
      PawnMoveLogger.logger.info("Testing Log")
    end

    it 'responds to js by default' do
      get :log, format: :js, xhr: true
      expect(response.content_type).to eq('text/javascript; charset=utf-8')
    end

    it 'returns the logs' do
      get :log, format: :js, xhr: true
      expect(assigns['logs']).to include('Testing Log')
    end
  end

  describe 'POST move' do
    let!(:pawn) { Pawn.new }

    subject do
      post :move, params: { moves: fixture_file_upload('data/test1.txt', 'text/text') }
    end


    before do
      allow(Pawn).to receive(:new).and_return(pawn)
    end

    it 'renders the move template' do
      subject
      expect(response).to render_template('move')
    end

    it 'responds to js by default' do
      subject
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end

    it 'returns the pawn after the moves' do
      expect(controller).to receive(:clear_pawn_move_logger).once

      subject

      expect(pawn.x_position).to eq(3)
      expect(pawn.y_position).to eq(3)
      expect(pawn.facing).to eq(Pawn::NORTH)
      expect(pawn.color).to eq(Pawn::BLACK_COLOR)
    end
  end
end
