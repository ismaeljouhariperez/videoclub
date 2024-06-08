import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["messages"]

  connect() {
    // Scroll to the bottom of the messages container
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    // Subscribe to the chatroom channel
    this.subscription = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.#insertMessageAndScrollDown(data) }
    )
    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)
  }

  // Clean the form after submitting a new message
  resetForm(event) {
    event.target.reset()
  }

  // Private method for inserting a new message and scrolling down
  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML('beforeend', data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }
}