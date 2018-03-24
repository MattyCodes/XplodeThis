class SchedulePanel < ApplicationRecord
  belongs_to :schedule
  has_and_belongs_to_many :speakers
end
