class Request < ApplicationRecord

  enum status: [:accepted, :denied, :pending]

  belongs_to :user
  belongs_to :group

  # se debe validar si ya existe una solicitud de un usuario al grupo en estado aceptado
  # validates_uniqueness_of :user, scope: :group

  scope :pending, -> (group_id) { where(status: :pending, group_id: group_id) }
  scope :accepted, -> (group_id) { where(status: :pending, group_id: group_id) }
  scope :denied, -> (group_id) { where(status: :pending, group_id: group_id) }
  scope :replied, -> (group_id) { where(status: [:accepted, :denied]) }
end
