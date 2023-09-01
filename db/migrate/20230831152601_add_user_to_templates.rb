class AddUserToTemplates < ActiveRecord::Migration[7.0]
  def change
    add_reference :templates, :user
  end
end
