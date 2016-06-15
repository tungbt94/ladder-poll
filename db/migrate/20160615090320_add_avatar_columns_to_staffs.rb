class AddAvatarColumnsToStaffs < ActiveRecord::Migration
  def up
    add_attachment :staffs, :avatar
  end

  def down
    remove_attachment :staffs, :avatar
  end
end
