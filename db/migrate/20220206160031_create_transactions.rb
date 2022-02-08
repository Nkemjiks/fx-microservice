class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :customer, foreign_key: true, null: false
      t.references :input_currency, null: false
      t.references :output_currency, null: false
      t.decimal :input_amount, precision: 11, scale: 2, null: false
      t.decimal :output_amount, precision: 11, scale: 2, null: false
      t.timestamps
    end

    add_foreign_key :transactions, :currencies, column: :input_currency_id
    add_foreign_key :transactions, :currencies, column: :output_currency_id
  end
end
