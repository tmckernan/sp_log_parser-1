# frozen_string_literal: true

require_relative '../../models/endpoint_visits'

module Counters
  # Count all visits for every endpoint
  class AllVisits
    def self.call(requests_map)
      all_visits = []

      requests_map.data.each do |endpoint, addresses|
        all_visits << EndpointVisits.new(endpoint, addresses.values.reduce(&:+))
      end

      all_visits
    end
  end
end
