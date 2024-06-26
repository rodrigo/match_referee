require 'rails_helper'

RSpec.describe Kill, type: :model do

  let(:match) { Match.create }

  context 'Creating a kill' do
    it 'creates successfully when required attributes are filled' do
      expect { Kill.create!(author_game_id: 1, victim_game_id: 2, weapon: 'front kick', match: match) }
        .to change { Kill.count }.by(1)
    end

    it 'return error when victim_game_id is nil' do
      expect { Kill.create!(author_game_id: 1, victim_game_id: nil, weapon: 'self punch', match: match) }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Victim game can't be blank"
        )
    end

    it 'return error when author_game_id is nil' do
      expect { Kill.create!(author_game_id: nil, victim_game_id: 2, weapon: 'wine', match: match) }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Author game can't be blank"
        )
    end

    it 'return error when weapon is nil' do
      expect { Kill.create!(author_game_id: 1, victim_game_id: 2, weapon: nil, match: match) }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Weapon can't be blank"
        )
    end

    it 'return error when match is nil' do
      expect { Kill.create!(author_game_id: 1, victim_game_id: 2, weapon: 'creativity', match: nil) }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Match must exist"
        )
    end
  end
end
