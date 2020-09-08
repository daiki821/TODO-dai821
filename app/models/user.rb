class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :boards, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_one :profile, dependent: :destroy


  delegate :age, :gender,:birthday, to: :profile, allow_nil: true

  def user_avatar
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end

  def nickname
    profile&.nickname || self.email.split('@').first
  end
  
  def introduction
    profile&.introduction
  end

  def gender
    profile&.gender
  end

  def birthday
    profile&.birthday
  end
end
