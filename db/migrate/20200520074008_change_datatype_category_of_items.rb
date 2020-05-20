class ChangeDatatypeCategoryOfItems < ActiveRecord::Migration[5.2]
  def up
    remove_reference :items, :category, foreign_key: true
  end

  def down
    add_reference :items, :category, foreign_key: true
  end
end
