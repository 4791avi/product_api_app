class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :sku_id
      t.text :categories
      t.text :tags
      t.integer :price
      t.date :expire_date
      t.text :metadata

      t.timestamps
    end
  end
end
