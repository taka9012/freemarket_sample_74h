# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# フリマアプリDB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|email|string|null: false, unique: true|
|password|string|nill: false|
### Association

## profile
|firstname|string|null:false|
|lastname|string|null: false|
|firstname_kana|string|null: false|
|lastname_kana|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|birth_day|integer|null: false|
|profile_sentence|text||
|icon_image|text||
|user|references|null: false, foreign_key: true|
### Association


## credit_cards
|card_number|integer|null: false, unique: true|
|effectivedate_yaer|integer|null: false|
|effectivedate_month|integer||



|adress_firstname|string|null: false|
|adress_lastname|string|null: false|
|adress_firstname_kana|string|null: false|
|adress_lastname_kana|string|null: false|
|postalcode|integer|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|buildingname-roomnumber|string||
|telephone_number|inreger||

### Association
- has_many :items
- has_many :buys

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|item_name|string|null: false|
|item_explanation|text|null: false|
|category|string|null: false|
|brand|string||
|item_status|string|null: false|
|delivery_fee_burden|string|null: false|
|shipping_area|string|null: false|
|shipping_date|integer|null: false|
|price|integer|null: false|
|user_id|integer|null: false, foreign_key: true
### Association
- belongs_to :user
- belongs_to :buy
- belongs_to :brand
- has_many :categories

## categoriesテーブル



## brandsテーブル


## buysテーブル




