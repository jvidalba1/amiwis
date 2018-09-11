class Group < ApplicationRecord
  has_many :games
  has_many :requests
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: true

  def assign_admin(user)
    self.admin_id = user.id
  end

  def admin
    User.find(self.admin_id)
  end

  def group_requests(user)
    self.requests.where(user: user, status: :pending)
  end

  def add_user(user)
    self.users << user
  end
end
