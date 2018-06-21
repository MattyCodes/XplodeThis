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

  def destroy_schedule
    self.schedule.destroy
  end
end
