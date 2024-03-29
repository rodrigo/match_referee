require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe LogParserJob, type: :job do
  Sidekiq::Testing.inline!

  let!(:log_path) { Rails.root  + 'spec/fixtures'}

  # The logs contains 209 kills and 5 matches
  context 'perform_async' do

    before do
      allow(Rails).to receive(:root).and_return(log_path)
      allow(File).to receive(:delete).and_return(true)
    end

    it 'create 209 kills' do
      expect { LogParserJob.perform_async }.to change { Kill.count}.by(209)
    end

    it 'create 5 matchs' do
      expect { LogParserJob.perform_async }.to change { Match.count}.by(5)
    end

    it 'delete all files from log directory' do
      Dir.foreach(log_path + 'log_files') do |filename|
        next if filename == '.' or filename == '..'
        expect(File).to receive(:delete).with(Pathname.new(log_path + 'log_files' + filename))
      end

      LogParserJob.perform_async
    end
  end
end
