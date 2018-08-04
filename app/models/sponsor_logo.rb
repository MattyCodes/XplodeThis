class SponsorLogo < ApplicationRecord
  scope :to_display_on_home_page, -> { where(display_on_home_page: true) }

  validates :logo, presence: true
  validates :name, presence: true
  has_many :city_logo_dependencies
  has_many :cities, through: :city_logo_dependencies

  mount_uploader :logo, AvatarUploader

  def city_index_for(city)
    if cities.include?(city)
      city_logo_dependencies.where(city: city).first&.index
    else
      nil
    end
  end
end
