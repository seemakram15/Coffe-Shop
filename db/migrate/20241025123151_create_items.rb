# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.decimal :tax, precision: 5, scale: 2, null: false
      t.decimal :discount, precision: 5, scale: 2, default: 0.0
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
