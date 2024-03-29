require 'rails_helper'

RSpec.describe MatchPlayer, type: :model do
  context 'Creating a match_player' do
    let(:match) { Match.create }

    it 'creates successfully when required attributes are filled' do
      expect { MatchPlayer.create!(game_id: 1, match: match, name: "Smurf") }
        .to change { MatchPlayer.count }.by(1)
    end

    it 'return error when game_id is nil' do
      expect { MatchPlayer.create!(game_id: nil, match: match, name: "Smurf") }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Game can't be blank"
        )
    end

    it 'return error when match is nil' do
      expect { MatchPlayer.create!(game_id: 1, match: nil, name: "Smurf") }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Match must exist"
        )
    end

    it 'return error when name is nil' do
      expect { MatchPlayer.create!(game_id: 1, match: match, name: nil) }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Name can't be blank"
        )
    end
  end
end
