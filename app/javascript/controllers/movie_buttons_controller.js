import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="movie-buttons"
export default class extends Controller {
  static values = { movieId: Number }

  connect() {
  }

  watched() {
    console.log("Watched!")
    console.log(this.movieIdValue)
    const movieId = this.movieIdValue;
    fetch(`/movies/${movieId}/movies_watched`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      }
    })
      .then(response => response.json())
      .then(data => {
        console.log('Success:', data);
        // if (data.status === 'success') {
        //   this.buttonTarget.textContent = 'Watched';
        //   // Update UI or notify user as necessary
        // } else {
        //   console.error('Error marking movie as watched:', data.message);
        // }
      })
      .catch(error => console.error('Error:', error));
  }


  like() {
    console.log("Liked!")
  }

  watchLater() {
    console.log("Watch Later!")
  }

  addToList() {
    console.log("Added to List!")
  }

}
