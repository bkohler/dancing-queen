import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  submit(event) {
    const input = this.inputTarget
    if (!input.value.trim()) {
      event.preventDefault()
      return
    }
  }

  reset() {
    this.inputTarget.value = ""
    this.inputTarget.style.height = "auto"
    // Trigger resize event on textarea
    const event = new Event("input", { bubbles: true })
    this.inputTarget.dispatchEvent(event)
  }
}