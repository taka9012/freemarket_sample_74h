class RenameColumnsWithIdToItems < ActiveRecord::Migration[5.2]
  def up
    rename_column :items, :item_status, :item_status_id
    rename_column :items, :postage_type, :postage_type_id
    rename_column :items, :postage_burden, :postage_burden_id
    rename_column :items, :shipping_date, :shipping_date_id
    rename_column :items, :shipping_area, :shipping_area_id
    rename_column :items, :trading_status, :trading_status_id
  end

  def down
    rename_column :items, :item_status_id, :item_status
    rename_column :items, :postage_type_id, :postage_type
    rename_column :items, :postage_burden_id, :postage_burden
    rename_column :items, :shipping_date_id, :shipping_date
    rename_column :items, :shipping_area_id, :shipping_area
    rename_column :items, :trading_status_id, :trading_status
  end
end
