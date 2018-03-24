class CreateSchedule < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.integer :city_id
    end
  end
end
