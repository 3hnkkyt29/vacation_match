class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ゲストログイン用
  def self.guest
    find_or_create_by!(name: 'guest' ,email: 'guest@user') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
