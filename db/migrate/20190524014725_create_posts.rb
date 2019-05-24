class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :body, null: false
      t.string :title, null: false
      t.string :picture
      t.references :challenge, foreign_key: true

      t.timestamps
    end
  end
end
