class RemoveTokenUpdateFromPatients < ActiveRecord::Migration[7.0]
  def change
    remove_column :patients, :token_update, :string
  end
end
