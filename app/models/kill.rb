class Kill < ApplicationRecord
  belongs_to :match
  validates :author_game_id, presence: true
  validates :victim_game_id, presence: true
  validates :weapon, presence: true

  def author
    MatchPlayer.find_by(game_id: author_game_id, match_id: match.id)
  end

  def victim
    MatchPlayer.find_by(game_id: victim_game_id, match_id: match.id)
  end
end
