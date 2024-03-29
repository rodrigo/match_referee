
require 'rails_helper'
require 'swagger_helper'

describe "Matches API" do
  let(:match) { Match.create }
  let!(:victim) { MatchPlayer.create(name: 'pernilongo', game_id: 1, match: match) }
  let!(:author) { MatchPlayer.create(name: 'self', game_id: 2, match: match) }
  let!(:kill) { Kill.create(victim_game_id: 1, author_game_id: 2, weapon: 'Raquete Elétrica', match: match) }

  path '/matches' do
    get 'Get a list of matchs' do
      tags 'Matches'
      produces 'application/json'
      response '200', 'matches found' do

        example 'application/json', :example, [
          {
            id: 299,
            created_at: "2024-03-29T19:13:09.297Z",
            updated_at: "2024-03-29T19:13:09.297Z",
            total_kills: 20,
            players: [
              "Ismilinguido",
              "Pernilongo"
            ],
            kills: {pernilongo: 10, ismilinguido: 10}
          }
        ]
        run_test! do |response|
          data = JSON.parse(response.body)[0]
          match_details = match.details
          expect(data['id']).to eq(match.id)
          expect(data['total_kills']).to eq(match_details[:total_kills])
          expect(data['players']).to eq(match_details[:players])
          expect(data['kills']).to eq(match_details[:kills])
        end
      end
    end
  end

  path '/matches/{id}' do
    get 'Retrieves a match' do
      tags 'Matches'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'
      response '200', 'match found' do

        example 'application/json', :example, {
            id: 299,
            created_at: "2024-03-29T19:13:09.297Z",
            updated_at: "2024-03-29T19:13:09.297Z",
            total_kills: 20,
            players: [
              "Ismilinguido",
              "Pernilongo"
            ],
            kills: {pernilongo: 10, ismilinguido: 10}
          }

        let(:id) { match.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          match_details = match.details
          expect(data['id']).to eq(match.id)
          expect(data['total_kills']).to eq(match_details[:total_kills])
          expect(data['players']).to eq(match_details[:players])
          expect(data['kills']).to eq(match_details[:kills])
        end
      end

      response '404', 'match not found' do
        let(:id) { match.id + 1 }
        run_test!
      end
    end
  end

  path '/matches/{id}/kills_per_weapon' do
    let!(:second_kill) { Kill.create(victim_game_id: 2, author_game_id: 1, weapon: 'Picada', match: match) }

    get 'Retrieves a list of kills per weapon from a match' do
      tags 'Matches'
      parameter name: :id, in: :path, type: :string
      produces 'application/json'
      response '200', 'match found' do

        example 'application/json', :example, {
            "Raquete Elétrica" => 5,
            "Picada" => 1
          }

        let(:id) { match.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          match_details = match.details
          expect(data).to eq(match.kills_per_weapon)
        end
      end

      response '404', 'match not found' do
        let(:id) { match.id + 1 }
        run_test!
      end
    end
  end
end
