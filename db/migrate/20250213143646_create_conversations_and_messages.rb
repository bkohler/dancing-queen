class CreateConversationsAndMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.references :queen, null: false, foreign_key: true
      t.text :context
      t.timestamps
    end

    create_table :messages do |t|
      t.references :conversation, null: false, foreign_key: true
      t.text :content
      t.string :role
      t.timestamps
    end

    add_column :queens, :speaking_style, :text
    add_column :queens, :personality_traits, :text
    add_column :queens, :historical_context, :text
  end
end
