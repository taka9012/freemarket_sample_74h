class RenameColumnShippingAreaOfItems < ActiveRecord::Migration[5.2]
  def up
    rename_column :items, :shipping_area_id, :shipping_area
  end

  def down
    rename_column :items, :shipping_area, :shipping_area_id
  end
end
