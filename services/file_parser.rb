# frozen_string_literal: true

# Read the file line by line and send it to the RequestsMap
# @param file_loader [FileLoader]
class FileParser
  def initialize(file_loader:)
    @file_loader = file_loader
    @requests_map = RequestsMap.new
  end

  def call(file_path); end
end
