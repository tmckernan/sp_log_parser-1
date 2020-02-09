# frozen_string_literal: true

require_relative 'services/file_parser'
require_relative 'services/file_loader'
require_relative 'services/server_log_parser'
require_relative 'services/visits_sorter'
require_relative 'utils/stdout_reporter'

file_parser = FileParser.new(file_loader: FileLoader.new)
server_log_parser = ServerLogParser.new(parser: file_parser, sorter: VisitsSorter)

begin
  server_log_parser.parse(ARGV[0])
rescue StandardFileError => e
  puts e.message
  return
end

STDOUTReporter.call(server_log_parser.all_visits, line_format: "%s %s visits\n")
puts ''
STDOUTReporter.call(server_log_parser.unique_visits, line_format: "%s %s unique views\n")
