class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :requests
  has_many :inscriptions

  has_and_belongs_to_many :games
  has_and_belongs_to_many :groups

  def member?(group)
    self.groups.include?(group)
  end

  def enrolled(game)
    self.inscriptions.find_by(game_id: game.id, status: [:active, :bench])
  end

  # def inscription(game)
  #   self.inscriptions.find_by(game_id: game.id)
  # end

end
