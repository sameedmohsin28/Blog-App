class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :bio
      t.string :photo
      t.integer :posts_counter

      t.timestamps
    end
  end
end

# Inside /bin>
# rails generate migration CreateUsers name:string bio:string photo:string posts_counter:integer
