class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :icon_image, IconUploader

  validates :profile_sentence, length: { maximum: 500 }
end
