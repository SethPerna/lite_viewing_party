class AddColumnToParties < ActiveRecord::Migration[5.2]
  def change
    add_column :parties, :host, :integer
  end
end
