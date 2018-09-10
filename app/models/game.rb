class Game < ApplicationRecord
  extend TimeSplitter::Accessors

  belongs_to :group
  has_and_belongs_to_many :users
  has_many :inscriptions

  scope :current_games, -> { where(status: [:active, :full]) }

  enum status: [:active, :inactive, :full]

  validates :game_date, presence: true

  split_accessor :game_date

  def is_full?
    current_users == limit_users
  end

  def join_date_time(date, time)
    DateTime.parse("#{date} #{time} -05").in_time_zone("Bogota")
  end

end
