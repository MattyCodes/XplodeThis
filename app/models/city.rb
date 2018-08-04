class City < ApplicationRecord
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  has_and_belongs_to_many :sponsor_logos
  has_one :schedule
  after_destroy :destroy_schedule
  mount_uploader :header_image, HeaderUploader

  def to_param
    slug
  end

  def selected_and_available_logos
    logos = ( self.sponsor_logos + SponsorLogo.all ).uniq
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
