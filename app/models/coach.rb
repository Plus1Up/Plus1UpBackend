class Coach < ApplicationRecord
  validates :mailAddress, presence: true
  validates :name, presence: true
  validates :password, presence: true
  validates :lastname, presence: true

  validates :mailAddress, :uniqueness => true
end
