class ChangeColumnOfItems < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :trading_status_id, :string, default: 1
  end

  def down
    change_column :items, :trading_status_id, :string
  end
end
