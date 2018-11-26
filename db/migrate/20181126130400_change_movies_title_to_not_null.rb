class ChangeMoviesTitleToNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :title, :string, null: false
  end
end
