class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.text          :profile_sentence
      t.string        :icon_image
      t.references    :user              , null: false, foreign_key: true
      t.timestamps
    end
  end
end
