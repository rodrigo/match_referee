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

      next if line.split(' ')[1] != 'Kill:'
      killer = line.split(':')[3][/(.*?)#{Regexp.escape('killed')}/m, 1].strip
      victim = line[/#{Regexp.escape('killed')}(.*?)#{Regexp.escape('by')}/m, 1].strip
      weapon = line.split('by')[1].strip
      kills  << {author: killer, victim: victim, weapon: weapon, match_id: @match.id}
    end

    Kill.insert_all(kills)
  end
end
