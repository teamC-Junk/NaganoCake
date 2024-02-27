class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :last_name
      t.string :first_name
      t.string :last_name_kana
      t.string :first_name_kana
      t.string :post_code
      t.string :address
      t.string :phone_number
      t.boolean :is_active, default: true
      
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.index ["email"], name: "index_customers_on_email", unique: true
      t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true

      t.timestamps
    end
  end
end
