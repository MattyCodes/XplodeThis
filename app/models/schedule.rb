class Schedule < ApplicationRecord
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  has_many :schedule_panels, :dependent => :destroy

  def to_param
    slug
  end
end
