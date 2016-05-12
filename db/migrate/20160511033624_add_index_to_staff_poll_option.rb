class AddIndexToStaffPollOption < ActiveRecord::Migration
  def change
    add_index :staffs, :id, unique: true
    add_index :polls, :id, unique: true
    add_index :options, :id
  end
end
