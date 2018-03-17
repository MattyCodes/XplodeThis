class AddHomePageToSponsorLogos < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsor_logos, :display_on_home_page, :boolean, default: false
  end
end
