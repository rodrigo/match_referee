class MatchPlayer < ApplicationRecord
  belongs_to :match
  validates :name, presence: true
  validates :game_id, presence: true
end
