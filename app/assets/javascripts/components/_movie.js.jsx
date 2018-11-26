class Movie extends React.Component{
  constructor(props) {
    super(props);
    this.state = { editable: false };

    this.handleEdit = this.handleEdit.bind(this);
    this.handleReset = this.handleReset.bind(this);
  };

  handleEdit() {
    if(this.state.editable) {
      let title = this.title.value;
      let description = this.description.value;
      let id = this.props.movie.id;
      let movie = { id: id, title: title, description: description };
      this.props.handleUpdate(movie);
    }

    this.setState({
      editable: !this.state.editable
    });
  };

  handleReset() {
    this.setState({ editable: false });
  }

  render() {
    let title = this.state.editable ?
      <div className="form-group">
        <input type='text' className="form-control"
          ref={input => this.title = input}
          defaultValue={this.props.movie.title} />
      </div> :
      <h3>{this.props.movie.title}</h3>;

    let description = this.state.editable ?
      <div className="form-group">
        <textarea className="form-control" rows='10'
          ref={textarea => this.description = textarea}
          defaultValue={this.props.movie.description} />
        </div> :
      <p className="description">{this.props.movie.description}</p>;

    let resetButton = this.state.editable ?
      <button className="btn btn-outline-secondary" onClick={() => this.handleReset()}>Cancel</button> :
      '';

    return(
      <div className="post">
        <div className="post-title">{title}</div>
        <div>{description}</div>
        <div className="form-group">
          <button className="btn btn-primary" onClick={() => this.handleEdit()}>{this.state.editable? 'Save' : 'Edit'}</button>
          <button className="btn btn-danger" onClick={() => this.props.handleDelete(this.props.movie.id)}>Delete</button>
          {resetButton}
        </div>
      </div>
    )
  }
}
