class CreateSchedulePanelsSpeakers < ActiveRecord::Migration[5.0]
  create_table :schedule_panels_speakers do |t|
    t.integer :speaker_id
    t.integer :schedule_panel_id
  end
end
