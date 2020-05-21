class Item < ApplicationRecord
  belongs_to :user
  belongs_to :brand, optional: true
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :brand

  validates_associated :images
  validates :name, :images, :explanation, :category, :item_status_id, :postage_type_id,
  :postage_burden_id, :shipping_area, :shipping_date_id, :trading_status_id, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 100000000}
  validates :explanation, length: { maximum: 1000 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_status
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :postage_burden
  belongs_to_active_hash :shipping_date
  belongs_to_active_hash :trading_status

end
