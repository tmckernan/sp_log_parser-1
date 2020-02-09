# frozen_string_literal: true

require 'rspec'

require_relative '../spec_helper'
require_relative '../../services/file_loader'
require_relative '../../errors/standard_file_error'
require_relative '../../errors/file_not_found_error'
require_relative '../../errors/unallowed_extension_error'

RSpec.describe FileLoader do
  describe '#load' do
    subject { described_class.new }

    context 'when no file path provided' do
      it 'raises StandardFileError' do
        expect { subject.load(nil) }.to raise_error(StandardFileError)
      end
    end

    context "when file doesn't exist" do
      let(:file_path) { 'spec/logfiles/not_exist/somefile.log' }

      it 'raises FileNotFoundError' do
        expect { subject.load(file_path) }.to raise_error(FileNotFoundError)
      end
    end

    context 'when file has a wrong extension' do
      let(:file_path) { 'spec/logfiles/webserver.csv' }

      it 'raises UnallowedExtensionError' do
        expect { subject.load(file_path) }.to raise_error(UnallowedExtensionError)
      end
    end

    context 'when the file is correct' do
      let(:file_path) { 'spec/logfiles/webserver.log' }

      it 'opens a file' do
        expect(subject.load(file_path)).to be_an_instance_of(File)
      end
    end
  end
end
