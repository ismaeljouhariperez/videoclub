import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = ["input"]

  connect() {
    this.updatePrompt()
    this.interval = setInterval(() => this.updatePrompt(), 2000)
  }

  disconnect() {
    clearInterval(this.interval)
  }

  updatePrompt() {
    const prompts = ["Describe your movie genre for tonight", "A funny movie with Brad Pitt", "Horror movie with clowns", "Best movies of Charlie Chaplin", "Sci-fi movies longer than 2 hours", "Spongebob adventures"]
    const prompt = prompts[Math.floor(Math.random() * prompts.length)]
    this.inputTarget.placeholder = prompt
  }
}
