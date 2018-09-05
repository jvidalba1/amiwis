class Game < ApplicationRecord
  belongs_to :group
  has_and_belongs_to_many :users
  has_many :inscriptions

  enum status: [:active, :inactive, :full]

  def is_full?
    current_users == limit_users
  end

end
