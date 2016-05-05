class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.integer :id
      t.integer :manager_id
      t.String :email
      t.integer :key_person
      t.String :department
      t.String :division
      t.boolean :actived

      t.timestamps null: false
    end
  end
end
