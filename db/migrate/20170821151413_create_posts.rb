class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :post_id
      t.string :url
      t.string :title
      t.string :thumbnail
      t.string :top_comment
      t.string :post_hint
      t.integer :ups
      t.string :permalink


      t.timestamps
    end
  end
end
