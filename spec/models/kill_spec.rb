require 'rails_helper'

RSpec.describe Kill, type: :model do

  let(:match) { Match.create }

  context 'Creating a kill' do
    it 'creates successfully when required attributes are filled' do
      expect { Kill.create!(author: 'Spider Silva', victim: 'Belfort', weapon: 'front kick', match: match) }
        .to change { Kill.count }.by(1)
    end

    it 'return error when victim is nil' do
      expect { Kill.create!(author: 'Tyler Durden', victim: nil, weapon: 'self punch', match: match) }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Victim can't be blank"
        )
    end

    it 'return error when author is nil' do
      expect { Kill.create!(author: nil, victim: 'Borrachinha', weapon: 'wine', match: match) }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Author can't be blank"
        )
    end

    it 'return error when weapon is nil' do
      expect { Kill.create!(author: 'Thor', victim: 'Hela', weapon: nil, match: match) }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Weapon can't be blank"
        )
    end

    it 'return error when match is nil' do
      expect { Kill.create!(author: 'out', victim: 'of', weapon: 'creativity', match: nil) }
        .to raise_error(
          ActiveRecord::RecordInvalid,
          "Validation failed: Match must exist"
        )
    end
  end
end
