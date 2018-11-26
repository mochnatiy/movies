class ChangeMoviesDescriptionToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :description, :text, null: false
  end
end
