class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :staff_id, null: false
      t.string :content, null: false
      t.timestamps null: true
    end
  end
end
