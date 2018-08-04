class CreateCityLogoDependencies < ActiveRecord::Migration[5.0]
  def change
    create_table :city_logo_dependencies do |t|
      t.integer :city_id
      t.integer :sponsor_logo_id
      t.integer :index
    end
  end
end
