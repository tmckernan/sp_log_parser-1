# frozen_string_literal: true

# Hash of the endpoints as a keys and hash of an IP and count of visits as a value
# { '/some/endpoint' => { '1.2.3.4' => 2 } }
# @param data [Hash] an initial data
class RequestsMap
  attr_reader :data

  def initialize(data = {})
    @data = data
  end

  def add_request(request); end
end
