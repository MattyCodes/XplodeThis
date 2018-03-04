class CreateSpeakers < ActiveRecord::Migration[5.0]
  def change
    create_table :speakers do |t|
      t.string :name
      t.string :title
      t.string :avatar
      t.string :email
      t.string :bio
      t.string :website

      t.timestamps
    end
  end
end
