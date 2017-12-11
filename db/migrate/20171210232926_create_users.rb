class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string :login, null: false
      t.index :login, unique: true
      t.timestamps
    end
    execute 'ALTER TABLE "users" ADD CONSTRAINT check_login CHECK (login != \'\')'
  end

  def down
    drop_table :users
  end
end
