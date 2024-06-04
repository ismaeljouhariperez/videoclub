import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-the-list"
export default class extends Controller {
  static targets = ["items", "form"]

  connect() {
    console.log("Connected");
    console.log(this.element)
    console.log(this.formTarget)
  }

  send(event) {
    event.preventDefault()

    fetch(this.formTarget.action, {
      method: "POST", // Could be dynamic with Stimulus values
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then((data) => {
        if (data.inserted_item) {
          // beforeend could also be dynamic with Stimulus values
          this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
        this.formTarget.outerHTML = data.form
      })
  }
}
