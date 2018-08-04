class RemoveDisplayOnHomePageFromSponsorLogos < ActiveRecord::Migration[5.0]
  def change
    remove_column :sponsor_logos, :display_on_home_page
  end
end
