import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { movieId: Number, movieSection: String, listId: Number }
  static targets = ["AddToWatched", "AddToWatchLater", "AddToFavorites", "AddToList"]

  connect() {
    this.updateVisibility();

    this.element.addEventListener('mouseleave', () => {
      this.hideUnselectedButtons();
    });

    this.element.addEventListener('mouseenter', () => {
      this.showAllButtons();
    });
  }

  updateVisibility() {
    this.hideButton(this.AddToListTarget);
    this.hideButton(this.AddToFavoritesTarget, 'favorite');
    this.hideButton(this.AddToWatchedTarget, 'watched');
  }

  hideUnselectedButtons() {
    this.hideButton(this.AddToListTarget);
    this.hideButton(this.AddToFavoritesTarget, 'favorite');
    this.hideButton(this.AddToWatchedTarget, 'watched');
  }

  showAllButtons() {
    this.AddToListTarget.classList.remove('d-none');
    this.AddToFavoritesTarget.classList.remove('d-none');
    this.AddToWatchedTarget.classList.remove('d-none');
  }

  hideButton(element, className) {
    if (!className || !element.classList.contains(className)) {
      element.classList.add('d-none');
    }
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

  fetchMovie(is_watched, action, url, el) {
    const requestBody = this.createRequestBody(is_watched);
    this.performFetch(url, requestBody)
      .then(data => {
        // console.log('Success:', data);
        this.updateCard(data, action, this.movieSectionValue, el);
        // Show toast message here
        this.show_toast("Update Successful", data.message, 5000);  // Adjust message and delay as needed
      })
      .catch(error => {
        console.error('Error:', error);
        // Optionally, show an error toast
        this.show_toast("Error", "Failed to update movie information.", 5000);
      });
  }


  createRequestBody(is_watched) {
    return JSON.stringify({
      movie_id: this.movieIdValue,
      is_watched: is_watched,
      section: this.movieSectionValue
    });
  }

  performFetch(url, body) {
    const headers = this.createHeaders();
    return fetch(url, { method: 'POST', headers, body })
      .then(response => this.handleResponse(response))
      .then(response => response.json());
  }

  createHeaders() {
    const token = document.querySelector('[name="csrf-token"]').content;
    return {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-CSRF-Token": token
    };
  }

  handleResponse(response) {
    if (!response.ok) throw new Error(`HTTP status ${response.status}`);
    return response;
  }

  addToList(event) {
    event.preventDefault();
    const listId = event.currentTarget.dataset.movieButtonsListIdValue;
    const requestBody = this.createListRequestBody(listId);
    const url = `/movies/${this.movieIdValue}/list_movies`;

    this.performFetch(url, requestBody)
      .then(data => {
        // console.log('Success:', data);
      })
      .catch(error => {
        // console.error('Error:', error);
      });
  }

  createListRequestBody(listId) {
    return JSON.stringify({
      list_id: listId,
      movie_id: this.movieIdValue
    });
  }

  updateCard(data, action, section, el) {
    this.logData(data, action);
    this.toggleClassOnElement(el, action);
    this.updateWatchStatus(data);

    if (this.isValidSection(section)) {
      this.handleSectionBasedActions(data, section);
    }
  }

  logData(data, action) {
    // console.log("data:", data);
    // console.log(action);
  }

  toggleClassOnElement(element, className) {
    element.classList.toggle(className);
  }

  updateWatchStatus(data) {
    if (data.is_watched) {
      this.AddToWatchLaterTarget.classList.remove('watch_later');
    } else {
      this.AddToWatchedTarget.classList.remove('watched');
    }
  }

  isValidSection(section) {
    return section !== "" && section !== undefined && section !== null;
  }

  handleSectionBasedActions(data, section) {
    if (this.shouldRemoveWatchStatus(data, section)) {
      this.fadeAndRemoveElement(this.element);
    } else if (this.shouldRemoveFromFavorites(data, section)) {
      this.fadeAndRemoveElement(this.element);
    }
  }

  shouldRemoveWatchStatus(data, section) {
    return (data.message === 'Movie watch status removed' ||
            data.message === 'Movie changed as watched' ||
            data.message === 'Movie changed as watch later') &&
           (section === 'watched' || section === 'watch_later');
  }

  shouldRemoveFromFavorites(data, section) {
    return data.message === 'Movie removed from favorites' && section === 'favorites';
  }

  fadeAndRemoveElement(element) {
    element.classList.add('fade');
    setTimeout(() => {
      element.remove();
    }, 700);
  }

  show_toast(toast_header, toast_message, delay) {
    let toast_template_html = `
      <div aria-atomic="true" aria-live="assertive"
        class="toast position-fixed bottom-0 end-0 m-3 border-0"
        role="alert" id="toast_message-${Date.now()}"
      >
        <div class="toast-header border-0 rounded d-flex justify-content-between">
          <p class="m-0 p-0">${toast_message}</p>
          <button aria-label="Close" class="btn-close"
            data-bs-dismiss="toast" type="button"></button>
        </div>
      </div>
    `;

    const toast_wrapper = document.createElement("template");
    toast_wrapper.innerHTML = toast_template_html.trim();
    const awesome_toast = toast_wrapper.content.firstChild;
    document.body.appendChild(awesome_toast);

    new bootstrap.Toast(awesome_toast, {
      autohide: true,
      delay: delay
    }).show();
  }


}
