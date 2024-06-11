import { Controller } from "@hotwired/stimulus";
import Siema from "siema";

export default class extends Controller {

  static targets = ['siema'];
  connect() {
    this.initSiema();
  }

  initSiema() {
    this.siemaTargets.map(target => {
      return new Siema({
        selector: target,
        duration: 200,
        easing: 'ease-out',
        perPage: {
          768: 2,
          1024: 5,
          1440: 6
        },
        startIndex: 0,
        loop: true
      });
    });

    window.addEventListener('resize', () => {
      this.siemaTargets.forEach(target => {
        target.siema.resizeHandler();
      });
    });
  }

  prev() {
    this.siemaInstances.prev();
  }

  next() {
    this.siemaInstances.next();
  }

  disconnect() {
    if (this.siema) {
      this.siema.destroy();
    }
  }
}
