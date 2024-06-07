import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "buttons" ]
  static values = { movieId: Number, movieSection: String }

  connect() {
  }

  fetchMovie(is_watched, action, url, el) {
    const movieId = this.movieIdValue;
    const section = this.movieSectionValue;
    console.log(`Movie ID: ${movieId}, Section: ${section}, Watched: ${is_watched}`);
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
      el.classList.add(action);
    })
    .catch(error => console.error('Error:', error));
  }

  addToWatched(e) {
    const el = e.currentTarget
    const url = `/watched_movies`;
    this.fetchMovie('true', 'watched', url, el);
  }

  addToWatchLater(e) {
    const el = e.currentTarget
    const url = `/watched_movies`;
    this.fetchMovie('false', 'watch_later', url, el);
  }

  addToFavorites(e) {
    const el = e.currentTarget
    console.log(this.buttonsTarget)
    const favoriteButton = this.buttonsTarget.querySelector('i.favorite');
    const url = `/favorites`;
    this.fetchMovie('', 'favorite', url, el);
  }

  addToList() {
    console.log("Added to List!")
  }

  updateCard(data, action) {
    // console.log(data.section, action);
    const cardElement = this.element;
    if ((data.section === 'watched' || data.section === 'watch_later') && data.section !== action) {
      cardElement.remove();
    }
  }

}
