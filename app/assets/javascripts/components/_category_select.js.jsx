class CategorySelect extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      categories: []
    };
  }

  componentDidMount(){
    fetch('/api/v1/categories.json')
      .then((response) => { return response.json() })
      .then((data) => { this.setState({ categories: data }) });
  }

  render() {
    let options = [];
    options.push(<option key={0} value="">Select category</option>)

    this.state.categories.forEach((category) => {
      options.push(
        <option
          key={category.id}
          value={category.id}
          selected={category.id === this.props.current_option}>
          {category.title}
        </option>
      );
    });

    return(
      <select className="form-control" ref={this.props.reference} required>
        {options}
      </select>
    )
  }
}
