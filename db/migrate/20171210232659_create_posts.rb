class CreatePosts < ActiveRecord::Migration[5.1]
  def up
    create_table :posts do |t|
      t.references :user

      t.string :ip_address
      t.float :average_rate, null: false, default: 0, index: true
      t.string :subject, null: false
      t.text :body, null: false

      t.timestamps
    end
    execute 'ALTER TABLE "posts" ADD CONSTRAINT check_subject CHECK (subject != \'\')'
    execute 'ALTER TABLE "posts" ADD CONSTRAINT check_body CHECK (body != \'\')'
  end
  def down
    drop_table :posts
  end
end
