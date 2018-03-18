class City < ApplicationRecord
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  has_and_belongs_to_many :sponsor_logos

  mount_uploader :header_image, HeaderUploader
  def to_param
    slug
  end
end
