class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.belongs_to :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
