# This migration comes from auth (originally 20200321090406)
class RolifyCreateAuthRoles < ActiveRecord::Migration[5.2]
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, :polymorphic => true

      t.timestamps
    end

    create_table(:auth_users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end
    
    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:auth_users_roles, [ :user_id, :role_id ])
  end
end
