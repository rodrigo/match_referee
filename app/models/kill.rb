class Kill < ApplicationRecord
  belongs_to :match
  validates :author, presence: true
  validates :victim, presence: true
  validates :weapon, presence: true
end
