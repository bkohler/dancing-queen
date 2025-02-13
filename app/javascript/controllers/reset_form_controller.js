import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  reset() {
    this.element.reset()
    const textarea = this.element.querySelector("textarea")
    if (textarea) {
      textarea.style.height = "auto"
      const event = new Event("input", { bubbles: true })
      textarea.dispatchEvent(event)
    }
  }
}