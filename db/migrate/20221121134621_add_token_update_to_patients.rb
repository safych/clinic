class AddTokenUpdateToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :token_update, :string, null: false, default: ""
  end
end
