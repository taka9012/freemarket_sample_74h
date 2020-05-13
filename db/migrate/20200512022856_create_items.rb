class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string      :name           , null: false
      # t.text        :explanation    , null: false
      t.integer     :price          , null: false
      # t.references  :brand          , foreign_key: true
      # t.references  :category       , null: false, foreign_key: true
      # t.string      :item_status    , null: false
      # t.string	    :postage_type   , null: false
      # t.string      :postage_burden , null: false
      # t.string      :shipping_area  , null: false
      # t.string      :shipping_date  , null: false
      # t.string      :trading_status , null: false
      # t.references  :user           , null: false, foreign_key: true
      t.timestamps
    end
  end
end
