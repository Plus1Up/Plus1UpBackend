class Client < ApplicationRecord
  validates :mail_address, presence: true
  validates :password, presence: true
  validates :name, presence: true
  validates :last_name, presence: true

  validates :mail_address, uniqueness: true

  belongs_to :coach
end
