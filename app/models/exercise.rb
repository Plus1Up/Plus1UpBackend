class Exercise < ApplicationRecord
  enum category: [:triceps, :chest, :shoulder, :biceps, :abs, :back, :forearm, :thigh, :glutes, :cardio, :calf]

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true

  belongs_to :coach
end
