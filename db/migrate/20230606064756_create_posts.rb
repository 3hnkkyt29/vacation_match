class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.integer :tag, null: false, default: 0
      t.string :title, null: false
      t.text :body, null: false
      t.text :keyword, null: false

      t.timestamps
    end
  end
end
