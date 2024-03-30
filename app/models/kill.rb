class Kill < ApplicationRecord
  belongs_to :match
  validates :author_game_id, presence: true
  validates :victim_game_id, presence: true
  validates :weapon, presence: true
end
