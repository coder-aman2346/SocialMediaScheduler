class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.datetime :scheduled_at
      t.boolean :published

      t.timestamps
    end
  end
end
