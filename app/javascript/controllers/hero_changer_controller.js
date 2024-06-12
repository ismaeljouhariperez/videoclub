import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hero"]
  currentImageIndex = 0
  imagesUrl = [
    "https://exitmag.fr/wp-content/uploads/sites/21/2024/04/The-Fall-Guy-1-Ryan-Gosling.webp",
    "https://images.cinefil.com/movies/1159600.webp",
    "https://www.ecrannoir.fr/wp-content/uploads/2024/01/0071433.webp",
    "https://www.rayonvertcinema.org/wp-content/uploads/2024/01/The-Zone-of-Interest-Jonathan-Glazer.jpg",
    "https://www.festival-deauville.com/wp-content/uploads/2023/07/comp-photo-film-past-lives-a24-ok.jpg",
  ];

  connect() {
    this.heroTarget.classList.add('initial');
    setTimeout(() => {
      this.heroTarget.classList.remove('initial');
      this.heroTarget.classList.add('active');
    }, 300);

    this.interval = setInterval(() => {
      this.changeBackgroundImage();
    }, 8000);
  }

  disconnect() {
    clearInterval(this.interval);
  }

  changeBackgroundImage() {
    this.currentImageIndex = (this.currentImageIndex + 1) % this.imagesUrl.length;
    const newImageUrl = this.imagesUrl[this.currentImageIndex];
    const gradient = "linear-gradient(to bottom, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3) 70%, rgba(255, 255, 255, 1) 100%)";

    this.heroTarget.style.backgroundImage = `${gradient}, url('${newImageUrl}')`;

    this.heroTarget.classList.remove('active');
    setTimeout(() => {
      this.heroTarget.classList.add('active');
    }, 300);
  }
}
