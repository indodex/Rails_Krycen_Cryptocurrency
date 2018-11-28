class CreateCoinPrices < ActiveRecord::Migration
  def change
    create_table :coin_prices do |t|
      t.string :currency
      t.decimal :ask, precision: 10, scale: 2
      t.decimal :bid, precision: 10, scale: 2
      t.decimal :avg_24h, precision: 10, scale: 2
      t.decimal :volume_btc, precision: 10, scale: 2
      t.decimal :volume_percent, precision: 10, scale: 2

      t.timestamps
    end
  end
end
