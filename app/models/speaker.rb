class Speaker < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  def to_param
    slug
  end
end
