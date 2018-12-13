class AddIsDeletedToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :is_deleted, :boolean, null: false, default: false
  end
end
