import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="movie-buttons"
export default class extends Controller {
  static values = { movieId: Number, movieSection: String }

  connect() {
  }

  fetchMovie(is_watched, action) {
    const movieId = this.movieIdValue;
    const section = this.movieSectionValue;
    console.log(`Movie ID: ${movieId}, Section: ${section}, Watched: ${is_watched}`);
    const url = `/watched_movies`;
    const token = document.querySelector('[name="csrf-token"]').content;
    fetch(url, {
      method: 'POST',
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": token
      },
      body: JSON.stringify({ movie_id: movieId, is_watched: is_watched, section: section })
    })
    .then(response => {
      if (!response.ok) throw new Error(`HTTP status ${response.status}`);
      return response.json();
    })
    .then(data => {
      console.log('Success:', data);
      this.updateCard(data, action);
    })
    .catch(error => console.error('Error:', error));
  }

  updateCard(data, action) {
    console.log(data.section, action);
    const cardElement = this.element;
    if ((data.section === 'watched' || data.section === 'watch_later') && data.section !== action) {
      cardElement.remove();
    }
  }

  watched() {
    this.fetchMovie('true', 'watched');
  }

  watchLater() {
    this.fetchMovie('false', 'watch_later');
  }

  like() {
    console.log("Liked!")
  }

  addToList() {
    console.log("Added to List!")
  }

}
