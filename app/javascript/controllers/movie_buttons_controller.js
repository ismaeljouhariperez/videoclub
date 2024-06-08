import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { movieId: Number, movieSection: String }

  static targets = ["AddToWatched", "AddToWatchLater", "AddToFavorites"]


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
      this.updateCard(data, action, section, el);
    })
    .catch(error => console.error('Error:', error));
  }

  addToWatched(e) {
    const el = e.currentTarget
    const url = `/watched_movies`;
    this.fetchMovie(true, 'watched', url, el);
  }

  addToWatchLater(e) {
    const el = e.currentTarget
    const url = `/watched_movies`;
    this.fetchMovie(false, 'watch_later', url, el);
  }

  addToFavorites(e) {
    const el = e.currentTarget
    const url = `/favorites`;
    this.fetchMovie('', 'favorite', url, el);
  }

  addToList() {
    // console.log("Added to List!")
  }

  updateCard(data, action, section, el) {
    console.log("data:", data);
    console.log(action);

    const cardElement = this.element;
    el.classList.toggle(action);
    if (data.is_watched === true) {
      this.AddToWatchLaterTarget.classList.remove('watch_later');
    } else {
      this.AddToWatchedTarget.classList.remove('watched');
    }

    if (section !== "" && section !== undefined && section !== null) {
      console.log('Section found');

      if ( (data.message === 'Movie watch status removed' || data.message === 'Movie changed as watched' || data.message === 'Movie changed as watch later' || data.message === 'Movie removed from favorites')) {
        cardElement.classList.add('fade');
        setTimeout(() => {
          cardElement.remove();
        }, 700);
      }
    }
  }
}
