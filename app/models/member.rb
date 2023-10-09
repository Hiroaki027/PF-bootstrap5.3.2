class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :nullify #該当のmemberが退会しても投稿に対してのいいねを残す為 nullifyでmemberがnullでもrecordとしてfavoritesは残る　
  has_many :comments, dependent: :destroy
  
  has_one_attached :profile_image
  
  GUEST_MEMBER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_MEMBER_EMAIL) do |member|
      member.password = SecureRandom.urlsafe_base64
      member.last_name = "ゲスト"
      member.first_name = "会員"
      member.nick_name = "ゲスト会員"
      member.residence = "地球"
    end
  end
  
  def guest_member?
    email == GUEST_MEMBER_EMAIL
  end
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end
end