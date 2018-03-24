class CreateSchedulePanel < ActiveRecord::Migration[5.0]
  def change
    create_table :schedule_panels do |t|
      t.integer :schedule_id
      t.string :time
      t.string :title
    end
  end
end
