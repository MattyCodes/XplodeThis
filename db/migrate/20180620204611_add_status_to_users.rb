class AddStatusToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :status, :integer, default: 1

    User.where(status: nil).map do |user|
      user.pending!
    end
  end
end
