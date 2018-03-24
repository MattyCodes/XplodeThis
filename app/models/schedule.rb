class Schedule < ApplicationRecord
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  has_many :schedule_panels

  def to_param
    slug
  end
end
