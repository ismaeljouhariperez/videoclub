import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    // console.log("Dark mode controller connected");
    // if (localStorage.getItem("darkMode") === "true") {
    //   this.toggle();
    // }
  }

  toggle() {
    const darkMode = !document.body.classList.contains("dark-mode");
    document.body.classList.toggle('dark-theme');
    // localStorage.setItem("darkMode", darkMode);
  }
}
