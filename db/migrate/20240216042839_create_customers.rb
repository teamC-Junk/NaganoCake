class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :last_name
      t.string :first_name
      t.string :last_name_kana
      t.string :first_name_kana
      # t.string :email
      # t.string :encrypted_password
      t.string :post_code
      t.string :address
      t.string :phone_number
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
