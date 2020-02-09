# frozen_string_literal: true

require 'rspec'

require_relative '../../services/server_log_parser'
require_relative '../../models/requests_map'
require_relative '../../services/file_parser'
require_relative '../../services/visits_sorter'
require_relative '../../services/visits_counter'
require_relative '../../constants/counter_constants'

RSpec.describe ServerLogParser do
  subject { described_class.new(parser: parser, sorter: sorter) }

  let(:parser) { instance_double(FileParser) }
  let(:sorter) { VisitsSorter }
  let(:requests_map) { instance_double(RequestsMap) }
  let(:file_path) { 'some/path/to/file.log' }

  describe '#parse' do
    it 'parses the log file' do
      expect(parser).to receive(:call).with(file_path).and_return(requests_map)
      expect(subject.parse(file_path)).to eq(requests_map)
    end
  end

  describe 'getting visits' do
    let(:visits_counter) { instance_double(VisitsCounter) }
    let(:counter_result) { [] }
    let(:sorter_result) { [] }

    before do
      expect(parser).to receive(:call).with(file_path).and_return(requests_map)
      expect(VisitsCounter).to receive(:new).with(requests_map).and_return(visits_counter)

      subject.parse(file_path)
    end

    describe '#all_visits' do
      it 'calls sorter for all all visits' do
        expect(visits_counter).to receive(:call)
          .with(CounterConstants::CounterTypes::ALL_VISITS)
          .and_return(counter_result)
        expect(sorter).to receive(:sort).with(counter_result).and_return(sorter_result)

        expect(subject.all_visits).to eq(sorter_result)
      end
    end

    describe '#unique_visits' do
      it 'calls sorter for unique visits' do
        expect(visits_counter).to receive(:call)
          .with(CounterConstants::CounterTypes::UNIQUE_VISITS)
          .and_return(counter_result)
        expect(sorter).to receive(:sort).with(counter_result).and_return(sorter_result)

        expect(subject.unique_visits).to eq(sorter_result)
      end
    end
  end
end
