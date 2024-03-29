require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'methods' do

    let(:match) { Match.create }
    let!(:victim) { MatchPlayer.create(name: 'Godzilla', game_id: 1, match: match) }
    let!(:author) { MatchPlayer.create(name: 'Kong', game_id: 2, match: match) }
    let!(:kills) { Kill.create(
      [
        {victim_game_id: 2, author_game_id: 1, weapon: 'Atomic Breath', match: match},
        {victim_game_id: 2, author_game_id: 1, weapon: 'slap', match: match},
        {victim_game_id: 1, author_game_id: 2, weapon: 'Writers willpower', match: match},
        {victim_game_id: 2, author_game_id: 1, weapon: 'Tail spin', match: match},
        {victim_game_id: 2, author_game_id: 1, weapon: 'Atomic Breath', match: match},
        {victim_game_id: 2, author_game_id: 1022, weapon: 'Fall', match: match}
      ]
    )}

    context 'details' do
      it 'build additional attributes for match' do
        expect(match.details).to include({
          id: match.id,
          total_kills: 6,
          kills: {"Godzilla"=>4, "Kong"=>0},
          players: ["Godzilla", "Kong"]
        })
      end
    end

    context 'kills_per_weapon' do
      it 'return list of kills per weapon' do
        expect(match.kills_per_weapon).to eq({
          "Atomic Breath" => 2,
          "slap" => 1,
          "Tail spin" => 1,
          "Writers willpower" => 1,
          "Fall" => 1
        })
      end
    end
  end
end
