# frozen_string_literal: true

require 'rspec'

require_relative '../../models/requests_map'
require_relative '../../models/request'

RSpec.describe RequestsMap do
  subject { described_class.new }
  let(:request) { instance_double(Request, endpoint: endpoint, ip: ip) }
  let(:endpoint) { '/some/endpoint' }
  let(:ip) { '1.2.3.4' }

  describe '#add_request' do
    context 'when request exists' do
      subject { described_class.new(endpoint => { ip => 1 }) }

      it 'increments visits count' do
        subject.add_request(request)
        expect(subject.data[endpoint][ip]).to eq 2
      end
    end

    context "when request doesn't exist" do
      it 'adds the request with one visit' do
        subject.add_request(request)
        expect(subject.data[endpoint][ip]).to eq 1
      end
    end
  end
end
