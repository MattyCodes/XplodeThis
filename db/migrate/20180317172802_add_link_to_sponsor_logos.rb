class AddLinkToSponsorLogos < ActiveRecord::Migration[5.0]
  def change
    add_column :sponsor_logos, :link, :string
  end
end
