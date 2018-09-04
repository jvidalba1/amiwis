class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :requests

  has_and_belongs_to_many :games
  has_and_belongs_to_many :groups

  def member?(group)
    self.groups.include?(group)
  end

end
