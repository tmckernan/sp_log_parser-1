# frozen_string_literal: true

require_relative 'visits_counter'
require_relative '../constants/counter_constants'

# Parses server log and provides uniq and all visits data
# @param parser Any file parser
# @param sorter Any sorter working with EndpointVisits
class ServerLogParser
  def initialize(parser:, sorter:)
    @parser = parser
    @sorter = sorter
    @requests_map = {}
  end

  def parse(file_path)
    @requests_map = @parser.call(file_path)
  end

  def all_visits
    sorted_visits(CounterConstants::CounterTypes::ALL_VISITS)
  end

  def unique_visits
    sorted_visits(CounterConstants::CounterTypes::UNIQUE_VISITS)
  end

  private

  def visits_counter
    @_visits_counter ||= VisitsCounter.new(@requests_map)
  end

  def sorted_visits(counter_type)
    @sorter.sort(visits_counter.call(counter_type))
  end
end
