class Match < ApplicationRecord
  has_many :kills
  has_many :match_players

  def details
    attributes.merge(
      total_kills: kills.count,
      players: match_players.map(&:name),
      kills: total_score
    ).symbolize_keys
  end

  def kills_per_weapon
    kills.map { |kill| kill.weapon }.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
  end

  private

  def total_score
    score = kills.map { |k| k.author.name if k.author }.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
    kills.where(author_game_id: 1022).map {|k| score[k.victim.name] -= 1 }
    score.except(nil)
  end
end
