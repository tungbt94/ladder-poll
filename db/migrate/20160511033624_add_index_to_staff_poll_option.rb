class AddIndexToStaffPollOption < ActiveRecord::Migration
  def change
    add_index :staffs, :id, :integer, unique: true
    add_index :polls, :id, :integer, unique: true
    add_index :options, :id, :integer
  end
end
