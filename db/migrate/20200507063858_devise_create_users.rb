class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :nickname              , null: false
      t.string  :firstname             , null: false
      t.string  :lastname              , null: false
      t.string  :firstname_kana        , null: false
      t.string  :lastname_kana         , null: false
      t.integer :birth_year            , null: false
      t.integer :birth_month           , null: false
      t.integer :birth_day             , null: false
      t.string  :email                 , null: false, default: ""
      t.string  :encrypted_password    , null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
