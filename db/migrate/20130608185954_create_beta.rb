class CreateBeta < ActiveRecord::Migration
  def change
    create_table :beta do |t|
      t.string :manuscript_id
      t.string :user_id
      t.boolean :approval, default: false

      t.timestamps
    end
  end
end
