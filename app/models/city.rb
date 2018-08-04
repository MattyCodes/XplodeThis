class City < ApplicationRecord
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  has_many :city_logo_dependencies
  has_many :sponsor_logos, through: :city_logo_dependencies
  has_one :schedule
  after_destroy :destroy_schedule
  mount_uploader :header_image, HeaderUploader

  def to_param
    slug
  end

  def ordered_logos
    self.sponsor_logos.sort_by { |logo| [ logo.city_index_for(self) ? 1 : 0, logo.city_index_for(self) ] }
  end

  def selected_and_available_logos
    logos = ( self.ordered_logos + SponsorLogo.all ).uniq
    logos.map do |logo|
      {
        id: logo.id,
        name: logo.name,
        imageUrl: logo.logo&.url,
        selected: ( logo.cities.include?(self) )
      }
    end
  end

  def destroy_schedule
    self.schedule.destroy
  end
end
