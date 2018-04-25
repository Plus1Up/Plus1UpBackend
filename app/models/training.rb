class Training < ApplicationRecord
  validates :name, presence: true
  validates :weekday, presence: true

  belongs_to :client
end
