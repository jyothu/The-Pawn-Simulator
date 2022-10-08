require 'active_support/core_ext/module/delegation'

class PawnMoveLogger
  FILE_PATH = "#{Rails.root}/log/pawn_move_#{Rails.env}_log.log".freeze

  class << self
    delegate :info, :debug, :flush, to: :logger

    def logger
      @logger ||= Logger.new(FILE_PATH)
    end

    def truncate!
      `cat /dev/null > #{FILE_PATH}`
    end
  end
end
