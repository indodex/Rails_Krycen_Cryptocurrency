class AddLinkTextFieldToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :link_text, :string
  end
end
