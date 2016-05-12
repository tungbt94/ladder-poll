class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :content, null: false
      t.integer :staff_id, null: false

      t.timestamps null: false
    end
  end
end
