import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = [ "sidebar" ]

  connect() {
    console.log("Dark mode controller connected");
    if (localStorage.getItem("darkMode") === "true") {
      this.toggle();
    }
  }

  toggle() {
    const darkMode = !document.body.classList.contains("dark-mode");
    document.body.classList.toggle("dark-mode", darkMode);
    this.sidebarTarget.classList.toggle("dark-mode", darkMode);
    localStorage.setItem("darkMode", darkMode);
  }
}
