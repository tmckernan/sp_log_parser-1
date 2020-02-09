# frozen_string_literal: true

require 'rspec'

require_relative '../../services/file_parser'
require_relative '../../services/file_loader'
require_relative '../../models/requests_map'
require_relative '../../models/request'
require_relative '../../errors/corrupted_data_error'

RSpec.describe FileParser do
  subject { described_class.new(file_loader: file_loader) }

  let(:file_path) { '' }
  let(:file_loader) { instance_double(FileLoader) }
  let(:requests_map) { instance_double(RequestsMap) }
  let(:request) { instance_double(Request) }
  let(:file_like_instance) { StringIO.new(log_line) }
  let(:log_line) { '/some/endpoint 1.2.3.4' }

  describe '#call' do
    before do
      expect(RequestsMap).to receive(:new).and_return(requests_map)
      expect(file_loader).to receive(:load).with(file_path).and_return(file_like_instance)
      expect(Request).to receive(:new).with(log_line).and_return(request)
    end

    it 'creates request and send it to requests map' do
      expect(request).to receive(:validate!)
      expect(requests_map).to receive(:add_request).with(request)

      subject.call(file_path)
    end

    context 'when an error raised' do
      it 'closes the file' do
        expect(request).to receive(:validate!).and_raise(CorruptedDataError)
        expect(file_like_instance).to receive(:close)

        expect { subject.call(file_path) }.to raise_error(CorruptedDataError)
      end
    end
  end
end
