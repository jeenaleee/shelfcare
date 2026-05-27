class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.date :open_date
      t.integer :pao_months
      t.text :notes
      t.string :photo
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end
  end
end
