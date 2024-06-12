import { Controller } from "@hotwired/stimulus";
import Siema from "siema";

export default class extends Controller {
  static targets = ['siema'];

  connect() {

    this.siemaInstances = this.siemaTargets.map(target => {
      if (target.closest('.special')) {
        const siemaConfig = {
          selector: target,
          duration: 200,
          easing: 'ease-out',
          perPage: {
            768: 2,
          },
          startIndex: 0,
          loop: target.children.length > 6,
          draggable: false,
        };

        // Adjust `perPage` based on the number of children
        if (target.children.length > 6) {
          siemaConfig.perPage = {
            768: 2,
            1024: 5,
            1440: 6
          };
        } else {
          siemaConfig.perPage = {
            1024: target.children.length,
            1440: target.children.length
          };
        }

        const siema = new Siema(siemaConfig);
        target.siema = siema; // Associate the instance with the target element
        return siema;
      } else {
        const siemaConfig = {
          selector: target,
          duration: 200,
          easing: 'ease-out',
          perPage: {
            768: 2,
            1024: 5,
            1440: 6
          },
          startIndex: 0,
          loop: target.children.length > 6,
          draggable: target.children.length > 6,
        };

        const siema = new Siema(siemaConfig);
        target.siema = siema; // Associate the instance with the target element
        return siema;
      }
    });

    // Ensure that each Siema instance is properly resized
    this.siemaInstances.forEach(siema => {
      siema.resizeHandler();
    });
  }

  prev(event) {
    const siemaInstance = this.getSiemaInstance(event);
    if (siemaInstance) {
      siemaInstance.prev();
    }
  }

  next(event) {
    const siemaInstance = this.getSiemaInstance(event);
    if (siemaInstance) {
      siemaInstance.next();
    }
  }

  getSiemaInstance(event) {
    const siemaTarget = event.currentTarget.closest('[data-controller="carousel"]').querySelector('[data-carousel-target="siema"]');
    return siemaTarget ? siemaTarget.siema : null;
  }

  disconnect() {
    this.siemaInstances.forEach(siema => siema.destroy());
  }
}
