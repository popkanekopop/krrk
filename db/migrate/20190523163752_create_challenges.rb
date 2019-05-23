class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :body, null: false
      t.references :user, foreign_key: true
      t.string :title, null: false

      t.timestamps
    end
  end
end
