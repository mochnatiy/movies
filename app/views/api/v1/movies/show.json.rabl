object @movie
cache @movie
attributes :id, :title, :description, :category_id, :created_at
node(:category_title) { |movie| movie.category.title }
