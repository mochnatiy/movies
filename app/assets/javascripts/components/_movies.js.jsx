const Movies = (props) => {
  var movies = props.movies.map((movie) => {
    return(
      <div key={movie.id}>
        <Movie movie={movie}
          handleDelete={props.handleDelete}
          handleUpdate={props.handleUpdate} />
      </div>
    )
  });

  return(
    <div>
      {movies}
    </div>
  )
}
