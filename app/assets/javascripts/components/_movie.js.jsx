class Movie extends React.Component{
  constructor(props) {
    super(props);
    this.state = { editable: false };

    this.handleEdit = this.handleEdit.bind(this);
    this.handleReset = this.handleReset.bind(this);
  };

  handleEdit() {
    if(this.state.editable){
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
      <input type='text' ref={input => this.title = input} defaultValue={this.props.movie.title}/> :
      <h3>{this.props.movie.title}</h3>;

    let description = this.state.editable ?
      <textarea ref={textarea => this.description = textarea} defaultValue={this.props.movie.description}/> :
      <p>{this.props.movie.description}</p>;

    let resetButton = this.state.editable ?
      <button onClick={() => this.handleReset()}>Cancel</button> :
      '';


    return(
      <div>
        {title}
        {description}
        <button onClick={() => this.handleEdit()}>{this.state.editable? 'Save' : 'Edit'}</button>
        <button onClick={() => this.props.handleDelete(this.props.movie.id)}>Delete</button>
        {resetButton}
      </div>
    )
  }
}