class AddHistoricalDetailsToQueens < ActiveRecord::Migration[8.0]
  def change
    add_column :queens, :reign_start, :date
    add_column :queens, :reign_end, :date
    add_column :queens, :kingdom, :string
    add_column :queens, :achievements, :text
    add_column :queens, :image_attribution, :string
  end
end
