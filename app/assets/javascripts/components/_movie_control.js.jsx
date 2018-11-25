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

  handleFormSubmit(title, description) {
    let body = JSON.stringify({ movie: { title: title, description: description } });

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
    this.setState({
      movie: this.state.movies.concat(movie)
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
      movies: remainedMovies
    });
  }

  handleUpdate(movie) {
    fetch(`/api/v1/movies/${movie.id}`, {
      method: 'PUT',
      body: JSON.stringify({ movie: movie }),
      headers: {
        'Content-Type': 'application/json'
      }
    }).then((response) => {
      this.updateMovie(movie);
    });
  };

  updateMovie(movie) {
    let updatedMovies = this.state.movies.filter((m) => m.id !== movie.id);
    updatedMovies.push(movie);

    this.setState({
      movies: updatedMovies.sort((a, b) => a.id - b.id)
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
        <NewMovie handleFormSubmit={this.handleFormSubmit}/>
        <Movies movies={ this.state.movies }
          handleDelete={ this.handleDelete }
          handleUpdate={ this.handleUpdate } />
      </div>
    )
  }
}
