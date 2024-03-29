class Match < ApplicationRecord
  has_many :kills

  def kill_count
    kills.count
  end

end
