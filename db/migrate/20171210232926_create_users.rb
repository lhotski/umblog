class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :login, null: false, unique: true, index: true

      t.timestamps
    end
    execute 'ALTER TABLE "users" ADD CONSTRAINT check_login CHECK (login != \'\')'
  end
end
