class CreateManuscripts < ActiveRecord::Migration
  def change
    create_table :manuscripts do |t|
      t.string :title
      t.integer :draft
      t.string :genres

      t.timestamps
    end
  end
end
