class User < ApplicationRecord
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true

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
