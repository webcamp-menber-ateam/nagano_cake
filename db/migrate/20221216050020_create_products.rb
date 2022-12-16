class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|

      t.integer :genre_id,null: false
      t.string :name,null: false
      t.text :explanation,null: false
      t.integer :price,null: false
      t.boolean :is_active,null: false,default: true

      t.timestamps
    end
  end
end
