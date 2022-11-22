class AddTokenUpdateToDoctors < ActiveRecord::Migration[7.0]
  def change
    add_column :doctors, :token_update, :string, null: false, default: ""
  end
end
