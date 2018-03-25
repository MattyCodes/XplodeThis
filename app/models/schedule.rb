class Schedule < ApplicationRecord
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  belongs_to :city
  has_many :schedule_panels, :dependent => :destroy

  def to_param
    slug
  end
end
