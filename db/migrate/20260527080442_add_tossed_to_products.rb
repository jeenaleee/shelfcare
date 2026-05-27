class AddTossedToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :tossed, :boolean
  end
end
