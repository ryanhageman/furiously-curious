class AddAasmStateToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :aasm_state, :string
  end
end
