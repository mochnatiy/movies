class MovieControl extends React.Component {
  constructor(props) {
    super(props);
    this.state = { movies: [] };

    this.handleFormSubmit = this.handleFormSubmit.bind(this);
    this.addNewMovie = this.addNewMovie.bind(this);

    this.handleDelete = this.handleDelete.bind(this);
    this.deleteMovie = this.deleteMovie.bind(this);

    this.handleUpdate = this.handleUpdate.bind(this);
    this.updateMovie = this.updateMovie.bind(this);
  }

  handleFormSubmit(title, description, category_id) {
    let body = JSON.stringify({
      movie: {
        title: title,
        description: description,
        category_id: category_id
      }
    });

    fetch('/api/v1/movies', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: body,
    }).then(
      (response) => { return response.json() }
    ).then(
      (movie) => { this.addNewMovie(movie) }
    )
  }

  addNewMovie(movie) {
    $('#addNewMovie').modal('hide');
    this.setState({
      movies: this.state.movies.concat(movie).sort((a, b) => b.id - a.id)
    });
  }

  handleDelete(id){
    fetch(`/api/v1/movies/${id}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json'
      }
    }).then((response) => {
      this.deleteMovie(id);
    });
  }

  deleteMovie(id) {
    remainedMovies = this.state.movies.filter((movie) => movie.id !== id);

    this.setState({
      movies: remainedMovies.sort((a, b) => b.id - a.id)
    });
  }

  handleUpdate(movie) {
    fetch(`/api/v1/movies/${movie.id}`, {
      method: 'PUT',
      body: JSON.stringify({ movie: movie }),
      headers: {
        'Content-Type': 'application/json'
      }
    }).then(
      (response) => { return response.json() }
    ).then((movie) => {
      this.updateMovie(movie);
    });
  };

  updateMovie(movie) {
    let updatedMovies = this.state.movies.filter((m) => m.id !== movie.id);
    updatedMovies.push(movie);

    this.setState({
      movies: updatedMovies.sort((a, b) => b.id - a.id)
    });
  };

  componentDidMount(){
    fetch('/api/v1/movies.json')
      .then((response) => { return response.json() })
      .then((data) => { this.setState({ movies: data }) });
  }

  render() {
    return(
      <div>
        <NewMovie handleFormSubmit={this.handleFormSubmit} />
        <div className="pd-top-20">
          <h3 className="pb-3 mb-4 font-italic border-bottom">
            Existing Movies
          </h3>
          <Movies movies={ this.state.movies }
            handleDelete={ this.handleDelete }
            handleUpdate={ this.handleUpdate } />
        </div>
      </div>
    )
  }
}
