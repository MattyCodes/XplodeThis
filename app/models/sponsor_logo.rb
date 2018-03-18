class SponsorLogo < ApplicationRecord
  scope :to_display_on_home_page, -> { where(display_on_home_page: true) }
  validates :logo, presence: true
  validates :name, presence: true
  has_and_belongs_to_many :cities

  mount_uploader :logo, AvatarUploader
end
