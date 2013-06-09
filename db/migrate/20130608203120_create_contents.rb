class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :line
      t.integer :manuscript_id

      t.timestamps
    end
  end
end
