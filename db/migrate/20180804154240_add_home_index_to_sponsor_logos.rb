class AddHomeIndexToSponsorLogos < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsor_logos, :home_index, :integer, default: nil
  end
end
