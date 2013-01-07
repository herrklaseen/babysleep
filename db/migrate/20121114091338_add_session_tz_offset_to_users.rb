class AddSessionTzOffsetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_tz_offset, :integer, :null => false, :default => 0
  end
end
