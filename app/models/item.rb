class Item < ApplicationRecord
  # belongs_to :user
  # 未実装テーブルのアソシエーションはコメントアウト
  # has_many :comments, dependent: :destroy
  # has_many :likes, dependent: :destroy
  has_many :images, dependent: :destroy
  # belongs_to :category
  belongs_to :brand

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :brand
  validates_associated :images
  validates :name, :price, presence: true
  

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :item_status
  belongs_to_active_hash :postage_type
  belongs_to_active_hash :postage_burden
  belongs_to_active_hash :shipping_date
  belongs_to_active_hash :trading_status
end
