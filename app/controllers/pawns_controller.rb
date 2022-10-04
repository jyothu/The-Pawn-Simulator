class PawnsController < ApplicationController
  def index; end

  def move
    Board.instance
    pawn = Pawn.new
    
    File.read(params[:moves].path).each_line do |command|
      pawn.execute(command)
    end
  end

  def log
    @logs = `tail -n 50 #{PawnMoveLogger::FILE_PATH}`

    respond_to do |format|
      format.js
    end
  end

  private

end
