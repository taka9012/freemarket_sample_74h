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


## profileテーブル
|Column|Type|Options|
|------|----|-------|
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


## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false, unique: true|
|effectivedate_yaer|integer|null: false|
|effectivedate_month|integer|null: false|
|security_code|integer|null: false|
|user|references|null: false, foreign_key: true|
### Association


## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|firstname|string|null: false|
|lastname|string|null: false|
|firstname_kana|string|null: false|
|lastname_kana|string|null: false|
|postal_code|integer|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|house_number|string|null: false|
|building_name|string||
|telephone_number|inreger||
|user|references|null: false, foreign_key: true|
### Association


## sns_authenticationテーブル（SNS認証）
|Column|Type|Options|
|------|----|-------|
|provider|string|null: false|)) 
|sns_user_id|integer|null:false|
|login_token|integer|null: false|
|user|references|null: false, foreign_key: true|
### Association


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|explanation|text|null: false|
|image|text|null: false|
|price|integer|null: false|
|category|references|null: false, foreign_key: true|
|brand|references|foreign_key: true|
|condition|references|null: false, foreign_key: true|
|postage_type|||
|delivery_fee_burden|references|null: false, foreign_key: true||
|shipping_area|references|null: false, foreign_key: true|
|shipping_date|references|null: false, foreign_key: true|
|transaction_status|references|null: false, foreign_key: true|
|seller|references||
|buyer|references||
|transcation_complete_date|||
|user|references|null: false, foreign_key: true|
### Association
- belongs_to :user


## categoriesテーブル



## brandsテーブル






