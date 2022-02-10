class AddNewColumnToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :movie_id, :integer
  end
end
