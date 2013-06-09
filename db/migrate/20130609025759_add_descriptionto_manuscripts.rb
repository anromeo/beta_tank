class AddDescriptiontoManuscripts < ActiveRecord::Migration
  def up
    add_column :manuscripts, :description, :text
  end

  def down
  end
end
