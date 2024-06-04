import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
  connect() {
    console.log("Dark mode controller connected");
    if (localStorage.getItem("darkMode") === "true") {
      this.toggle();
    }
  }

  toggle() {
    const darkMode = !document.body.classList.contains("dark-mode");
    document.body.classList.toggle("dark-mode", darkMode);
    localStorage.setItem("darkMode", darkMode);
  }
}
