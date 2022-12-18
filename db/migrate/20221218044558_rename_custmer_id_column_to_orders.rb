class RenameCustmerIdColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_column :orders, :custmer_id, :customer_id
  end
end
