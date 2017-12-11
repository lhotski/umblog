class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user

      t.string :ip_address
      t.float :average_rate, null: false, default: 0, index: true
      t.string :subject, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
