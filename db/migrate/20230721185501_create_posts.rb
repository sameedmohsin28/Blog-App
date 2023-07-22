class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title
      t.text :text
      t.integer :comments_counter
      t.integer :likes_counter

      t.timestamps
    end

    add_foreign_key :posts, :users, column: :author_id, name: 'fk_posts_author_id'
    add_index :posts, :author_id
  end
end

# Inside \bin>
# rails generate migration CreatePosts author_id:integer:index title:string text:text comments_counter:integer likes_counter:integer
# then added line 13(below) manually
# add_foreign_key :posts, :users, column: :author_id, name: 'fk_posts_author_id'
