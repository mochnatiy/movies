const NewMovie = (props) => {
  let formFields = {}

  return(
    <form onSubmit={ (e) => { props.handleFormSubmit(formFields.title.value, formFields.description.value); e.target.reset(); } }>
      <div className="form-group">
        <input className="form-control"
          ref={input => formFields.title = input} placeholder='Enter the title of the movie' required />
      </div>
      <div className="form-group">
        <textarea className="form-control" rows="5"
          ref={textarea => formFields.description = textarea} placeholder='Enter a description' required />
      </div>
      <button className="btn btn-primary">Save</button>
    </form>
  )
}
