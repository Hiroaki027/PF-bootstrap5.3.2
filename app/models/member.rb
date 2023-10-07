class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :nullify
  has_many :post_comments, dependent: :destroy
  
  has_one_attached :profile_image
  
  GUEST_MEMBER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "ゲスト会員"
    end
  end
  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end
end