const NewMovie = (props) => {
  let formFields = {}

  return(
    <form onSubmit={ (e) => { props.handleFormSubmit(formFields.title.value, formFields.description.value); e.target.reset();}
  }>
      <p>
        <input ref={input => formFields.title = input} placeholder='Enter the title of the movie'/>
      </p>
      <p>
        <textarea ref={textarea => formFields.description = textarea} placeholder='Enter a description' />
      </p>
      <button>Submit</button>
    </form>
  )
}
