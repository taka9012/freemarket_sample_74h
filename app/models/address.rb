class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :firstname     , format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :lastname      , format: {with: /\A[ぁ-んァ-ン一-龥]/}
  validates :firstname_kana, format: {with: /\A[ァ-ヶー－]+\z/}
  validates :lastname_kana , format: {with: /\A[ァ-ヶー－]+\z/}
  validates :telephone_number, numericality: { only_integer: true }, length: { in: 10..11 }
end
