class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :id
      t.integer :poll_id
      t.float :sum_score

      t.timestamps null: false
    end
  end
end
