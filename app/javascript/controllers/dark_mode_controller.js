import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "sidebar", "container", "main"]

  connect() {
    console.log("Dark mode controller connected");
    if (localStorage.getItem("darkMode") === "true") {
      this.toggle();
    }
  }

  toggle() {
    const darkMode = !this.mainTarget.classList.contains("dark-mode");
    this.mainTarget.classList.toggle("dark-mode", darkMode);
    // localStorage.setItem("darkMode", darkMode);
  }
}
