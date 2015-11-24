class CreateImagems < ActiveRecord::Migration
  def change
    create_table :imagems do |t|

      t.timestamps null: false
    end
  end
end
