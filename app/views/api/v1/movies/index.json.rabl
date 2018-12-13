collection @movies, object_root: false
cache @movies
attributes :id, :title, :description, :category_id, :created_at
node(:category_title) { |movie| movie.category.title }
