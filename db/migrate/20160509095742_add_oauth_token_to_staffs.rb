class AddOauthTokenToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :provider, :string
    add_column :staffs, :uid, :string
    add_column :staffs, :oauth_token, :string
  end
end
