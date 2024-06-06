import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-form"
export default class extends Controller {
  static targets = ["form", "button"]

  toggle() {
    this.formTarget.classList.toggle("d-none");
    this.buttonTarget.classList.toggle("d-none");
  }
}
