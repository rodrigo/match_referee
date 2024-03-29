require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe LogParserJob, type: :job do
  Sidekiq::Testing.inline!

  let!(:log_path) { Rails.root  + 'spec/fixtures' }

  # The logs contains 209 kills, 16 match players and 5 matches
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

    it 'create 16 matchs players' do
      expect { LogParserJob.perform_async }.to change { MatchPlayer.count}.by(16)
    end

    it 'update the name of the MatchPlayer if change during the match' do
      # Here the player changes the name from Isgalamido to Jorge and Xablauzinho on the same match
      # Only Xablauzinho should exist

      LogParserJob.perform_async
      expect(MatchPlayer.find_by(name: "Xablauzinho")).not_to be_nil
      expect(MatchPlayer.find_by(name: "Isgalamido", match_id: MatchPlayer.find_by(name: "Xablauzinho").match_id)).to be_nil
      expect(MatchPlayer.find_by(name: "Jorge", match_id: MatchPlayer.find_by(name: "Xablauzinho").match_id)).to be_nil
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
