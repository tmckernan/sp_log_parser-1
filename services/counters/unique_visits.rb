# frozen_string_literal: true

require_relative '../../models/endpoint_visits'

module Counters
  # Count unique visits for every endpoint
  class UniqueVisits
    def self.call(requests_map)
      unique_visits = []

      requests_map.data.each do |endpoint, addresses|
        unique_visits << EndpointVisits.new(endpoint, addresses.keys.count)
      end

      unique_visits
    end
  end
end
