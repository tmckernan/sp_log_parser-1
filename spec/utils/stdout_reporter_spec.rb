# frozen_string_literal: true

require 'rspec'

require_relative '../../models/endpoint_visits'
require_relative '../../utils/stdout_reporter'

RSpec.describe STDOUTReporter do
  describe '.print' do
    let(:endpoints_visits) { [single_endpoint_visits] }
    let(:single_endpoint_visits) { EndpointVisits.new('/some/endpoint', 5) }

    context 'when format is defined' do
      let(:format) { 'endpoint: %s - %s visits' }
      let(:result_output) { "endpoint: #{single_endpoint_visits.endpoint} - #{single_endpoint_visits.visits} visits" }

      it 'prints within format' do
        expect { described_class.call(endpoints_visits, line_format: format) }.to output(result_output).to_stdout
      end
    end

    context 'when format is empty' do
      it 'prints calling inspect' do
        expect { described_class.call(endpoints_visits) }.to output(single_endpoint_visits.inspect).to_stdout
      end
    end
  end
end
