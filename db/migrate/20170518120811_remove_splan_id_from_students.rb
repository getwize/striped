class RemoveSplanIdFromStudents < ActiveRecord::Migration[5.0]
  def change
    remove_column :students, :splan_id_id, :integer
  end
end
