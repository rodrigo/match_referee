class LogParser < ApplicationJob
  queue_as :default

  PATH=Rails.root + 'log_files/'

  def perform
    Dir.foreach(PATH) do |filename|
      next if filename == '.' or filename == '..'
      parse_log(PATH + filename)
      # remove_file(filename)
    end
  end

  private

  def remove_file(filename)
  end

  def parse_log(filename)
    kills = []
    File.foreach(filename) do |line|
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
