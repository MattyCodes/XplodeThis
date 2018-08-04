class SponsorLogo < ApplicationRecord
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

  def self.for_home_page
    SponsorLogo.where.not(home_index: nil).order(home_index: :asc)
  end

  def self.for_home_page_json
    logos = ( SponsorLogo.for_home_page + SponsorLogo.all ).uniq
    logos.map do |logo|
      {
        id: logo.id,
        name: logo.name,
        imageUrl: logo.logo&.url,
        selected: ( logo.home_index.present? )
      }
    end
  end
end
