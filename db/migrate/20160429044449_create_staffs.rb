class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :manager_id, :default => 0
      t.string :email
      t.string :name
      t.integer :key_person, :default => 0
      t.string :department
      t.string :division
      t.boolean :actived ,:default => false
      t.timestamps null: false
    end
  end
end
