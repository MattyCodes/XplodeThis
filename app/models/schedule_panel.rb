class SchedulePanel < ApplicationRecord
  belongs_to :schedule
  has_and_belongs_to_many :speakers

  def self.with_valid_time
    self.all.select { |panel| !panel.time.to_time.nil? }
  end

  def as_json(args = nil)
    {
      id: id,
      title: title,
      time: time,
      speakers: speakers.map(&:as_json)
    }
  end
end
