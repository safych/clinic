class RemoveTokenUpdateFromDoctors < ActiveRecord::Migration[7.0]
  def change
    remove_column :doctors, :token_update, :string
  end
end
