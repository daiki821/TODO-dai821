class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  enum gender:{ male: 0, female: 1,}


  def age
    unless birthday.present?
      return '年齢を入力してください'
    end

    years = Time.zone.now.year - birthday.year
    days = Time.zone.now.yday - birthday.yday

    if days < 0
      "#{years - 1}歳"
    else
      "#{years}歳"
    end
  end
end
