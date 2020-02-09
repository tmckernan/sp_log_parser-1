# frozen_string_literal: true

require 'rspec'

require_relative '../../models/request'
require_relative '../../errors/corrupted_data_error'

RSpec.describe Request do
  subject { described_class.new(log_line) }

  describe '#validate!' do
    context 'when log line is invalid' do
      let(:log_line) { 'random string' }

      it 'raises CorruptedDataError' do
        expect { subject.validate! }.to raise_error(CorruptedDataError)
      end
    end

    context 'when log line is valid' do
      let(:log_line) { '/some/endpoint 1.2.3.4' }

      it 'does not raise errors' do
        expect { subject.validate! }.not_to raise_error
      end
    end
  end
end
