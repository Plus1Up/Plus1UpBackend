class Client < ApplicationRecord
  validates :mail_address, presence: true
  validates :password, presence: true
  validates :name, presence: true
  validates :last_name, presence: true

  validates :mail_address, uniqueness: true

  has_attached_file :diet_plan,
                    :path => ':rails_root/public/system/clients/:id/diet_plan/:filename',
                    :url => '/system/clients/:id/diet_plan/:filename'
  validates_attachment_content_type :diet_plan, :content_type => %w(image/jpeg image/png application/pdf)

  belongs_to :coach
  has_many :trainings
end
