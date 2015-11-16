class AddImageToImagem < ActiveRecord::Migration
  def change
    add_column :imagems, :image, :string
  end
end
