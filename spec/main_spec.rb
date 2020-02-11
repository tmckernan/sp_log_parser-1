# frozen_string_literal: true

require 'rspec'
require 'open3'

RSpec.describe 'main.rb' do
  describe 'script stdout' do
    subject { Open3.capture2("ruby #{script_path} #{logfile_path}").first }

    let(:script_path) { File.expand_path('../main.rb', dir_name) }
    let(:logfile_path) { File.expand_path('logfiles/webserver.log', dir_name) }
    let(:dir_name) { File.dirname(__FILE__) }
    let(:printed_result) { result_lines.join('') }
    let(:result_lines) do
      [
        "/some/interesting/route 5 visits\n",
        "/some_page 2 visits\n",
        "/contact 2 visits\n",
        "/help_page/1 2 visits\n",
        "\n",
        "/some/interesting/route 3 unique views\n",
        "/some_page 2 unique views\n",
        "/contact 2 unique views\n",
        "/help_page/1 2 unique views\n"
      ]
    end

    it 'print sorted list of visits to stdout' do
      expect(subject).to eq(printed_result)
    end

    context 'when no argument provided' do
      let(:logfile_path) { nil }

      it { is_expected.to eq("No file path provided\n") }
    end

    context 'when log file doesnt exist' do
      let(:logfile_path) { File.expand_path('logfiles/not_existing_file.log', dir_name) }

      it { is_expected.to eq("File not found [#{logfile_path}]\n") }
    end

    context 'when log file has a wrong extension' do
      let(:logfile_path) { File.expand_path('logfiles/webserver.csv', dir_name) }

      it { is_expected.to eq("File extension is unallowed. Allowed: .log\n") }
    end

    context 'when log file has incorrect data' do
      let(:logfile_path) { File.expand_path('logfiles/corrupted.log', dir_name) }

      it { is_expected.to eq("Data is incorrect: [/some_page 722.247.123.582.123]\n") }
    end
  end
end
