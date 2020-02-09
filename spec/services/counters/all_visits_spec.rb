# frozen_string_literal: true

require 'rspec'

require_relative '../../../services/counters/all_visits'
require_relative '../../../models/requests_map'
require_relative '../../../models/endpoint_visits'

RSpec.describe Counters::AllVisits do
  subject { described_class.call(requests_map) }

  describe '.call' do
    context 'when and address is met few times' do
      let(:requests_map) { instance_double(RequestsMap, data: { '/some/endpoint' => { '1.2.3.4' => 5 } }) }

      it { is_expected.to eq [EndpointVisits.new('/some/endpoint', 5)] }
    end

    context 'when an address is met one time' do
      let(:requests_map) { instance_double(RequestsMap, data: { '/some/endpoint' => { '1.2.3.4' => 1 } }) }

      it { is_expected.to eq [EndpointVisits.new('/some/endpoint', 1)] }
    end

    context 'when multiple addresses' do
      let(:requests_map) do
        instance_double(RequestsMap, data: { '/some/endpoint' => { '1.2.3.4' => 1, '1.2.3.5' => 2 } })
      end

      it { is_expected.to eq [EndpointVisits.new('/some/endpoint', 3)] }
    end

    context 'when multiple endpoints' do
      let(:requests_map) do
        instance_double(RequestsMap, data: { '/some/endpoint' => { '1.2.3.4' => 1 },
                                             'some/other/endpoint' => { '1.2.3.4' => 2 } })
      end

      it { is_expected.to eq [EndpointVisits.new('/some/endpoint', 1), EndpointVisits.new('some/other/endpoint', 2)] }
    end
  end
end
