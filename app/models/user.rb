class User < ApplicationRecord
  enum status: [ :active, :pending ]
  before_create :set_pending_if_no_status
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable

  def set_pending_if_no_status
    self.pending! if !status
  end
end
