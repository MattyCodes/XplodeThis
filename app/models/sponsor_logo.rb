class SponsorLogo < ApplicationRecord
  mount_uploader :logo, AvatarUploader
  validates :logo, presence: true
  validates :name, presence: true
end
