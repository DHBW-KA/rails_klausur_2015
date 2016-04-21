class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.belongs_to :ship_address, index: true, foreign_key: true
      t.belongs_to :bill_address, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
