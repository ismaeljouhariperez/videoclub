import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="movie-buttons"
export default class extends Controller {
  static values = { movieId: Number }
  static targets = ['card']

  connect() {
  }

  watched() {
    console.log("Watched movie with ID:", this.movieIdValue);
    const movieId = this.movieIdValue;
    const url = `/watched_movies`;
    const token = document.querySelector('[name="csrf-token"]').content;

    fetch(url, {
      method: 'POST',
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json", // Make sure to set Content-Type as application/json
        "X-CSRF-Token": token
      },
      body: JSON.stringify({ movie_id: movieId })
    })
    .then(response => {
      if (!response.ok) throw new Error(`HTTP status ${response.status}`);
      return response.json();
    })
    .then(data => {
      console.log('Success:', data);
      // Optionally update your UI based on the response
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
