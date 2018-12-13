class CategoryFilter extends React.Component {
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
    let list_items = [];

    this.state.categories.forEach((category) => {
      list_items.push(
        <li key={category.id}>
          <a href="#">
            {category.title}
          </a>
        </li>
      );
    });

    return(
      <ol className="list-unstyled mb-0">
        {list_items}
      </ol>
    )
  }
}
