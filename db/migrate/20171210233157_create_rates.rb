class CreateRates < ActiveRecord::Migration[5.1]
  def up
    create_table :rates do |t|
      t.references :post
      t.integer :value, null: false, default: 0, limit: 1

      t.timestamps
    end
    execute 'ALTER TABLE "rates" ADD CONSTRAINT check_value CHECK (value BETWEEN 1 AND 5)'
  end

  def down
    drop_table :rates
  end

end
