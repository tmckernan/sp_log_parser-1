# frozen_string_literal: true

require_relative '../constants/counter_constants'
require_relative '../services/counters/all_visits'
require_relative '../services/counters/unique_visits'

# Facade which selects a certain counter and calls it
# @param request_map [RequestMap] parsed requests map
class VisitsCounter
  TYPES_COUNTERS = {
    CounterConstants::CounterTypes::ALL_VISITS => ::Counters::AllVisits,
    CounterConstants::CounterTypes::UNIQUE_VISITS => ::Counters::UniqueVisits
  }.freeze

  def initialize(requests_map)
    @requests_map = requests_map
  end

  def call(counter_type)
    counter_class = TYPES_COUNTERS.fetch(counter_type)
    counter_class.call(@requests_map)
  end
end
