class CreateSpeakerSchedulePanels < ActiveRecord::Migration[5.0]
  create_table :speaker_schedule_panels do |t|
    t.integer :speaker_id
    t.integer :schedule_panel_id
  end
end
