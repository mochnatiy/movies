const NewMovie = (props) => {
  let formFields = {}

  return(
    <div className="modal fade" id="addNewMovie" tabIndex="-1" role="dialog" aria-hidden="true">
      <div className="modal-dialog" role="document">
        <div className="modal-content">
          <div className="modal-header">
            <h3 className="font-italic modal-title">
              Add New Movie
            </h3>
            <button type="button" className="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <form
            onSubmit={ (e) => { props.handleFormSubmit(formFields.title.value, formFields.description.value, formFields.category_id.value); e.target.reset(); } }>
            <div className="modal-body">
              <div className="form-group">
                <input className="form-control"
                  ref={input => formFields.title = input} placeholder='Enter the title of the movie' required />
              </div>
              <div className="form-group">
                <CategorySelect reference={select => formFields.category_id = select} />
              </div>
              <div className="form-group">
                <textarea className="form-control" rows="5"
                  ref={textarea => formFields.description = textarea} placeholder='Enter a description' required />
              </div>
              <div className="modal-footer justify-content-center">
                <button className="btn btn-primary">Save</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  )
}
