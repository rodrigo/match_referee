class LogParserJob
  include Sidekiq::Job

  queue_as :default

  def perform
    log_path = Rails.root + 'log_files/'

    Dir.foreach(log_path) do |filename|
      file_path = log_path + filename
      next if filename == '.' or filename == '..'
      parse_log(file_path)
      remove_file(file_path)
    end
  end

  private

  def remove_file(file_path)
    File.delete(file_path)
  end

  def parse_log(file_path)
    kills = []
    File.foreach(file_path) do |line|
      if line.include?('InitGame')
        @match = Match.create
      end

      if line.include?('ClientUserinfoChanged')
        name = line.split('\\')[1]
        game_id = line.split(' ')[2].to_i
        MatchPlayer.find_or_initialize_by(game_id: game_id, match_id: @match.id).update(name: name)
      end

      next if line.split(' ')[1] != 'Kill:'

      killer = line.split(' ')[2].to_i
      victim = line.split(' ')[3].to_i
      weapon = line.split('by')[1].strip

      kills  << {author_game_id: killer, victim_game_id: victim, weapon: weapon, match_id: @match.id}
    end

    Kill.insert_all(kills)
  end
end
