class PawnsController < ApplicationController
  def index; end

  def move
    debugger
  end

  def log
    @logs = `tail -n 50 #{PawnMoveLogger::FILE_PATH}`

    respond_to do |format|
      format.js
    end
  end
end
