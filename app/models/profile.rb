class Profile < ApplicationRecord
  belongs_to :user

  validates :profile_sentence, length: { maximum: 500 }
end
