class CityLogoDependency < ApplicationRecord
  belongs_to :sponsor_logo
  belongs_to :city
end
