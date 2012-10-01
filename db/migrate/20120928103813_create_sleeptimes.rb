class CreateSleeptimes < ActiveRecord::Migration
  def change
    create_table :sleeptimes do |t|
      t.datetime :start
      t.integer :duration
      t.integer :baby_id

      t.timestamps
    end
  end
end
