# frozen_string_literal: true

require 'rspec'

require_relative '../../models/endpoint_visits'
require_relative '../../services/visits_sorter'
require_relative '../../constants/sorter_constants'

RSpec.describe VisitsSorter do
  describe '.sort' do
    subject { described_class.sort(endpoints_visits, direction: sort_direction) }

    let(:endpoints_visits) do
      [
        EndpointVisits.new('/some/endpoint', 2),
        EndpointVisits.new('/some/endpoint', 5),
        EndpointVisits.new('/some/endpoint', 3)
      ]
    end

    let(:desc_endpoints_visits) do
      [
        EndpointVisits.new('/some/endpoint', 5),
        EndpointVisits.new('/some/endpoint', 3),
        EndpointVisits.new('/some/endpoint', 2)
      ]
    end

    let(:asc_endpoints_visits) do
      [
        EndpointVisits.new('/some/endpoint', 2),
        EndpointVisits.new('/some/endpoint', 3),
        EndpointVisits.new('/some/endpoint', 5)
      ]
    end

    context 'when default sort attribute is using' do
      subject { described_class.sort(endpoints_visits) }

      it 'sorts in descendig order' do
        expect(subject).to eq(desc_endpoints_visits)
      end
    end

    context 'when desc sort direction' do
      let(:sort_direction) { SorterConstants::DESC }

      it 'sorts in descendig order' do
        expect(subject).to eq(desc_endpoints_visits)
      end
    end

    context 'when asc sort direction' do
      let(:sort_direction) { SorterConstants::ASC }

      it 'sorts in ascending order' do
        expect(subject).to eq(asc_endpoints_visits)
      end
    end
  end
end
