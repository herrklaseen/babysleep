class CreateBabies < ActiveRecord::Migration
  def change
    create_table :babies do |t|
      t.string :name
      t.date :date_of_birth
      t.integer :parent_id

      t.timestamps
    end
  end
end
