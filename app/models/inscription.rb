class Inscription < ApplicationRecord

  belongs_to :user
  belongs_to :game

  # se debe validar con scope de game y user, y ademas tambn con el estado en activo

  # validates_uniqueness_of :game, scope: :user, message: "Ya estás inscrito a este partido"

  enum status: [:active, :inactive, :bench]

  scope :active, -> (game_id) { where(status: :active, game_id: game_id) }
  scope :inactive, -> (game_id) { where(status: :inactive, game_id: game_id) }
  scope :bench, -> (game_id) { where(status: :bench, game_id: game_id) }

  scope :alive, -> (game_id) { where(status: [:active, :bench], game_id: game_id) }

  def validate_game_quota!
    if self.game.full?
      self.bench!
    else
      self.active!
      self.game.current_users += 1
      self.game.save
      self.game.full! if self.game.is_full?
    end
  end

  def inactive_inscription!
    unless self.bench?
      bench_inscriptions = Inscription.bench(self.game.id)
      if bench_inscriptions.any?
        bench_inscriptions.first.active!
      else
        self.game.current_users -= 1
        self.game.active!
      end
    end
    self.inactive_at = Time.now
    self.inactive!
  end
end
