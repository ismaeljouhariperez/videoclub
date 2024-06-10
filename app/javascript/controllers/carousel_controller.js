import { Controller } from "@hotwired/stimulus";
import Siema from "siema";

export default class extends Controller {
  connect() {
    // Initialize Siema for the specific carousel element within this controller's element
    this.siema = new Siema({
      selector: this.element.querySelector('.siema'), // Specify the selector scoped to the controller element
      duration: 200,
      easing: 'ease-out',
      perPage: {
        768: 3,
        1024: 6,
        1440: 6
      },
      startIndex: 0,
      draggable: true,
      multipleDrag: true,
      threshold: 20,
      loop: true
    });
  }

  prev() {
    this.siema.prev();
  }

  next() {
    this.siema.next();
  }

  disconnect() {
    if (this.siema) {
      this.siema.destroy();
    }
  }
}
