class Playbill < ApplicationRecord
  enum status: { active: 1, archived: 0 }

  scope :active, -> { where(status: 1) }
end
