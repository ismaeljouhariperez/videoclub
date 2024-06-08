import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-bar-movie"
export default class extends Controller {
  static targets = ["inputBox"]

  connect() {
    // console.log('Hello, Stimulus!', this.inputBoxTarget);
  }

  openSearch() {
    this.inputBoxTarget.classList.add('open')
  }

  closeSearch() {
    this.inputBoxTarget.classList.remove('open')
  }
}
