class CretaeTodosTable < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.datetime :due
      t.datetime :ceatedAt, null: false
      t.integer :status, null: false, default: 0
    end
  end
end
