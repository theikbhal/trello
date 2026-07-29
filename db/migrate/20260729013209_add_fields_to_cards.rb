class AddFieldsToCards < ActiveRecord::Migration[8.1]
  def change
    add_column :cards, :deadline, :datetime
    add_column :cards, :assignee, :string
  end
end
