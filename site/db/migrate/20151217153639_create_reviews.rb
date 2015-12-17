class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :produto_id
      t.string :comment	
      t.integer :rating
      t.timestamps null: false
    end
    add_reference :reviews, :user, index: true, foreign_key: true
  end
end
