class AddNameToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :invite, :boolean
  end
end
