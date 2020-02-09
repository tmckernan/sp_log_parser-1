# frozen_string_literal: true

# Parses server log and provides uniq and all visits data
# @param parser Any file parser
# @param sorter Any sorter working with EndpointVisits
class ServerLogParser
  def initialize(parser:, sorter:)
    @parser = parser
    @sorter = sorter
  end

  def parse(file_path); end

  def all_visits; end

  def unique_visits; end
end
