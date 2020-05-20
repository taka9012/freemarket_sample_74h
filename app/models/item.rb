class Item < ApplicationRecord
  belongs_to :user
  # 未実装テーブルのアソシエーションはコメントアウト
  # has_many :comments, dependent: :destroy
  # has_many :likes, dependent: :destroy
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  belongs_to :category
  belongs_to :brand
  # belongs_to_active_hash :item_condition
  # belongs_to_active_hash :postage_type
  # belongs_to_active_hash :postage_burden
  # belongs_to_active_hash :shipping_date
end
