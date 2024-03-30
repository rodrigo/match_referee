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
    kills.map {|k| {author: k.author_game_id, victim: k.victim_game_id }}
    .inject(Hash.new(0)) { |h,i| i[:author] == 1022 ? h[i[:victim]] -= 1 : h[i[:author]] += 1; h }
    .inject(Hash.new(0)) { |h,s| h[MatchPlayer.find_by(game_id: s[0]).name] = s[1]; h }
  end
end
