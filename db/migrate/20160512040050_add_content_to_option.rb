class AddContentToOption < ActiveRecord::Migration
  def change
    add_column :options, :content, :string, :unique => false
  end
end
