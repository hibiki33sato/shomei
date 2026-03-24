class RemoveNameYomiFromSignatures < ActiveRecord::Migration[8.1]
  def change
    remove_column :signatures, :name_yomi, :string
  end
end
