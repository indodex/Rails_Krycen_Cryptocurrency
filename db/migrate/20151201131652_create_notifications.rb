class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification_text
      t.string :notification_color
      t.boolean :active
    end
  end
end
