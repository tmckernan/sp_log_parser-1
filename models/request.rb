# frozen_string_literal: true

# A model that represents single request from logs
# @param log_line [String] single string from logfile
class Request
  def initialize(log_line)
    @endpoint, @ip = log_line.split(' ')
  end

  def validate!; end
end
