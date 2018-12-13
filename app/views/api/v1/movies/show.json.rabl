object @movie
cache @movie
attributes :id, :title, :description, :category_id
node(:category_title) { |movie| movie.category.title }
