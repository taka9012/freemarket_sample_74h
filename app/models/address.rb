class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :firstname, :lastname, :firstname_kana, :lastname_kana, :postal_code, :prefectures, :city, :house_number, presence: true

  validates :firstname     , format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :lastname      , format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :firstname_kana, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :lastname_kana , format: {with: /\A[ァ-ヶー－]+\z/}
  validates :postal_code   , format: {with: /\A\d{7}\z/}
  validates :telephone_number, format: {with: /\A\d{10,11}\z/}, unless: -> { telephone_number.blank? }
end