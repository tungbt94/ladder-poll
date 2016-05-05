class CreateStaffPolls < ActiveRecord::Migration
  def change
    create_table :staff_polls do |t|
      t.integer :staff_id
      t.integer :poll_id
      t.integer :option_id

      t.timestamps null: false
    end
  end
end
