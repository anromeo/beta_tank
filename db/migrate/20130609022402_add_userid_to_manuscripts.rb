class AddUseridToManuscripts < ActiveRecord::Migration
  def change
    add_column :manuscripts, :user_id, :integer
  end
end
