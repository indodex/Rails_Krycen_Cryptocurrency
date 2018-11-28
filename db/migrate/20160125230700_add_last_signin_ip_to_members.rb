class AddLastSigninIpToMembers < ActiveRecord::Migration
  def change
    add_column :members, :last_signin_ip, :string
  end
end
