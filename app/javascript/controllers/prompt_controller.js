import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]


  displayLoader(e) {
    e.preventDefault();
    console.log('display loader');
    document.body.classList.add('loading');
    this.loader.removeAttribute('hidden');
    this.inputTarget.focus();
    setTimeout(() => {
      document.body.addEventListener('click', (e) => { this.hideLoader(e) });

    }, 3000);
  }

  hideLoader(e) {
    console.log('hide loader');
    document.body.classList.remove('loading');
    this.loader.setAttribute('hidden', '');
  }

  connect() {
    this.loader = document.querySelector(".loader");

    console.log('connected');
    this.phrases = [
        "Movies with Keanu Reeves",
        "Action movies 2h max",
        "French 60’s movies",
        "Movies with a twist ending",
        "I want to watch a movie with my mom",
        "I'm looking for a movie to watch with my kids",
        "A sad movie that will make me cry",
        "What was the movie with the talking dog",
        "Latest movies with Leonardo DiCaprio",
        "A movie directed by Quentin Tarantino"
    ];
    this.currentPhrase = this.phrases[0];
    this.isDeleting = false;
    this.letterCount = 0;
    this.phraseIndex = 0;
    this.typingSpeed = 100;
    this.cursorSpeed = 500;
    this.running = true; // Flag to control the running of animations
    this.updatePrompt();
    this.toggleCursorVisibility(true);
    this.inputTarget.addEventListener('focus', () => this.onFocus());
    this.inputTarget.addEventListener('blur', () => this.onBlur());
  }

  disconnect() {
    clearTimeout(this.timeout);
    clearTimeout(this.cursorTimeout);
    this.inputTarget.removeEventListener('focus', () => this.onFocus());
    this.inputTarget.removeEventListener('blur', () => this.onBlur());
  }

  updatePrompt() {
    if (!this.running) return; // Stop updating if not running

    const currentLength = this.currentPhrase.length;
    if (this.isDeleting) {
        this.letterCount--;
    } else {
        this.letterCount++;
    }

    this.inputTarget.placeholder = this.currentPhrase.substring(0, this.letterCount) + (this.cursorVisible ? '|' : '');

    if (!this.isDeleting && this.letterCount === currentLength) {
        setTimeout(() => { this.isDeleting = true; }, 1000);
    } else if (this.isDeleting && this.letterCount === 0) {
        this.isDeleting = false;
        this.phraseIndex = (this.phraseIndex + 1) % this.phrases.length;
        this.currentPhrase = this.phrases[this.phraseIndex];
    }

    this.timeout = setTimeout(() => this.updatePrompt(), this.typingSpeed);
  }

  toggleCursorVisibility(initial = false) {
    if (!this.running && !initial) return; // Stop blinking if not running

    if (!initial) {
        this.cursorVisible = !this.cursorVisible;
    }
    this.cursorTimeout = setTimeout(() => this.toggleCursorVisibility(), this.cursorSpeed);
  }

  onFocus() {
    this.running = false; // Stop animations on focus
    clearTimeout(this.timeout);
    clearTimeout(this.cursorTimeout);
    this.inputTarget.placeholder = ''; // Clear the placeholder when focused
  }

  onBlur() {
    if (this.inputTarget.value.trim() === '') {
        this.running = true; // Resume animations only if the input is empty
        this.updatePrompt();
        this.toggleCursorVisibility(true);
    }
  }
}
