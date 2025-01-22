class AddImageToQueens < ActiveRecord::Migration[8.0]
  def change
    add_column :queens, :image, :string
  end
end
