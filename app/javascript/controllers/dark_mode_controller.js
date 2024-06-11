import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["checkbox"]

  connect() {
    this.updateTheme();
  }

  updateTheme() {
    // Check if dark mode is saved in localStorage and update the body class and checkbox state
    const darkMode = localStorage.getItem("darkMode") === "true";
    document.body.classList.toggle('dark-theme', darkMode); // Apply dark-theme class based on the localStorage value
    this.checkboxTarget.checked = darkMode; // Set the checkbox status
  }

  toggle() {
    const isDarkMode = document.body.classList.toggle('dark-theme');
    localStorage.setItem("darkMode", isDarkMode); // Save the new state in localStorage
    this.checkboxTarget.checked = isDarkMode; // Update checkbox state to reflect the change
  }
}
