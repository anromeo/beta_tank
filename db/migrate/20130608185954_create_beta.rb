class CreateBeta < ActiveRecord::Migration
  def change
    create_table :beta do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :bio
      t.string :email

      t.timestamps
    end
  end
end
