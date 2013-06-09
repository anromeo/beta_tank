class CreateBeta < ActiveRecord::Migration
  def change
    create_table :beta do |t|
      t.integer :manuscript_id
      t.integer :user_id
      t.boolean :approval, default: false

      t.timestamps
    end
  end
end
