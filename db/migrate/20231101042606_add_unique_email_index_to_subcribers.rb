class AddUniqueEmailIndexToSubcribers < ActiveRecord::Migration[7.2]
  def change
    add_index :subscribers, :email, unique: true
  end
end
