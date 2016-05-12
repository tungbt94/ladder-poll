class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :poll_id
      t.timestamps null: false
    end
  end
end
