# frozen_string_literal: true

# Facade which selects a certain counter and calls it
# @param request_map [RequestMap] parsed requests map
class VisitsCounter
  def initialize(requests_map)
    @requests_map = requests_map
  end

  def call(counter_type); end
end
