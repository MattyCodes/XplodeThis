class CreateCityLogoDependency < ActiveRecord::Migration[5.0]
  def change
    create_table :cities_sponsor_logos do |t|
      t.integer :city_id
      t.integer :sponsor_logo_id
    end
  end
end
