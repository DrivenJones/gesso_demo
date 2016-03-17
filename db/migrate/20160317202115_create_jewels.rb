class CreateJewels < ActiveRecord::Migration
  def change
    create_table :jewels do |t|
      t.references :user, index: true
      t.string :color
      t.float :price
      t.float :weight
      t.string :jewel_name
      t.text :jewel_description

      t.timestamps
    end
  end
end
