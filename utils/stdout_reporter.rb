# frozen_string_literal: true

# Prints the endpoints visits in the defined format
class STDOUTReporter
  def self.call(endpoints_visits, line_format: nil)
    endpoints_visits.each do |single_endpoing_visits|
      if line_format.nil?
        print single_endpoing_visits.inspect
      else
        print format(line_format, single_endpoing_visits.endpoint, single_endpoing_visits.visits)
      end
    end
  end
end
