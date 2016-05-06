class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :manager_id
      t.string :email
      t.integer :key_person
      t.string :department
      t.string :division
      t.boolean :actived

      t.timestamps null: false
    end
  end
end
