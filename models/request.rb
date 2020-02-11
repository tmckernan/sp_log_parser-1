# frozen_string_literal: true

require_relative '../errors/corrupted_data_error'

# A model that represents single request from logs
# @param log_line [String] single string from logfile
class Request
  ENDPOINT_REGEX = /^\/\w+(\/\w+)*$/.freeze
  IP_REGEX = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/.freeze

  attr_reader :endpoint, :ip

  def initialize(log_line)
    @endpoint, @ip = log_line.split(' ')
  end

  def validate!
    raise CorruptedDataError, "Data is incorrect: [#{@endpoint} #{@ip}]" if @endpoint !~ ENDPOINT_REGEX || @ip !~ IP_REGEX
  end
end
