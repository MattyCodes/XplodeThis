class Speaker < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  has_and_belongs_to_many :schedule_panels

  def to_param
    slug
  end

  def as_json(args = nil)
    {
      id: id,
      title: title,
      name: name,
      avatar_url: avatar_url,
      slug: slug
    }
  end
end
