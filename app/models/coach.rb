class Coach < ApplicationRecord
  validates :mail_address, presence: true
  validates :name, presence: true
  validates :password, presence: true
  validates :last_name, presence: true

  validates :mail_address, :uniqueness => true

  has_many :exercises
end
