# frozen_string_literal: true

require_relative '../models/request'
require_relative '../models/requests_map'

# Read the file line by line and send it to the RequestsMap
# @param file_loader [FileLoader]
class FileParser
  def initialize(file_loader:)
    @file_loader = file_loader
    @requests_map = RequestsMap.new
  end

  def call(file_path)
    file = @file_loader.load(file_path)

    begin
      file.each_line do |log_line|
        add_line_to_the_map(log_line)
      end
    ensure
      file.close
    end

    @requests_map
  end

  private

  def add_line_to_the_map(log_line)
    request = Request.new(log_line)
    request.validate!

    @requests_map.add_request(request)
  end
end
