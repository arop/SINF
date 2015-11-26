class CreateProductDescriptions < ActiveRecord::Migration
  def change
    create_table :product_descriptions do |t|
      t.string :description
      t.string :idProduto

      t.timestamps null: false
    end
  end
end
