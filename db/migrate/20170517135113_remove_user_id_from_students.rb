class RemoveUserIdFromStudents < ActiveRecord::Migration[5.0]
  def change
    remove_column :students, :user_id, :integer
  end
end
