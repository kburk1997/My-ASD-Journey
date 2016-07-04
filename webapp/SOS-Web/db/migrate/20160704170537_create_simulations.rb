class CreateSimulations < ActiveRecord::Migration
  def change
    create_table :simulations do |t|
      t.string :title
      t.string :short_name
      t.string :image
      t.text :instructions
      t.text :long_desc

      t.timestamps
    end
  end
end
