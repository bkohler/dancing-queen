class CreateQueens < ActiveRecord::Migration[8.0]
  def change
    create_table :queens do |t|
      t.string :name
      t.text :facts

      t.timestamps
    end
  end
end
