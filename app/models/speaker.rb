class Speaker < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  has_and_belongs_to_many :schedule_panels

  def to_param
    slug
  end
end
