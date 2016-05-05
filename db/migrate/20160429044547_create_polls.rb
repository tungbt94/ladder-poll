class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :id
      t.String :content
      t.integer :stadd_id

      t.timestamps null: false
    end
  end
end
