class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :code
      t.string :symbol

      t.timestamps
    end
  end
end
