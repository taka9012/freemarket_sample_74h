class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string     :firstname             , null: false
      t.string     :lastname              , null: false
      t.string     :firstname_kana        , null: false
      t.string     :lastname_kana         , null: false
      t.integer    :postal_code           , null: false, limit: 8
      t.string     :prefectures           , null: false
      t.string     :city                  , null: false
      t.string     :house_number          , null: false
      t.string     :building_name
      t.string     :telephone_number      , null: false
      t.references :user                  , null: false, foreign_key: true
      t.timestamps
    end
  end
end
