class RemoveChefFromRecipes < ActiveRecord::Migration[5.0]
  def change
    remove_column :recipes, :chef, :string
  end
end
