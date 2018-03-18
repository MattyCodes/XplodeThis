class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :day
      t.string :date
      t.string :time
      t.string :venue
      t.text :event_ticket_code
      t.timestamps
    end
  end
end
