class PawnsController < ApplicationController
  def index; end

  def move
    Board.instance
    clear_pawn_move_logger
    @pawn = Pawn.new
    
    File.read(permitted_params[:moves].path).each_line do |command|
      @pawn.execute(command)
    end
  end

  def log
    @logs = `tail -n 50 #{PawnMoveLogger::FILE_PATH}`

    respond_to do |format|
      format.js
    end
  end

  private

  def clear_pawn_move_logger
    PawnMoveLogger.truncate!
  end

  def permitted_params
    params.permit(:moves)
  end
end
