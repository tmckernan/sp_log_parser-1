# frozen_string_literal: true

require 'rspec'

require_relative '../../services/visits_counter'
require_relative '../../services/counters/all_visits'
require_relative '../../services/counters/unique_visits'
require_relative '../../constants/counter_constants'

RSpec.describe VisitsCounter do
  subject { described_class.new(reuqests_map) }

  let(:reuqests_map) { instance_double('RequestsMap') }

  describe '#call' do
    context 'when counter type is ALL' do
      let(:counter_type) { CounterConstants::CounterTypes::ALL_VISITS }

      it 'calls AllVisits counter' do
        expect(Counters::AllVisits).to receive(:call).with(reuqests_map)
        subject.call(counter_type)
      end
    end

    context 'when counter type is UNIQUE' do
      let(:counter_type) { CounterConstants::CounterTypes::UNIQUE_VISITS }

      it 'calls UniqueVisits counter' do
        expect(Counters::UniqueVisits).to receive(:call).with(reuqests_map)
        subject.call(counter_type)
      end
    end
  end
end
