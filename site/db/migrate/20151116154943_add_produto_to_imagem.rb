class AddProdutoToImagem < ActiveRecord::Migration
  def change
    add_column :imagems, :idProduto, :string
  end
end
