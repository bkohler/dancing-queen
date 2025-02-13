import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.resize()
  }

  resize() {
    this.element.style.height = "auto"
    this.element.style.height = `${this.element.scrollHeight}px`
  }

  keydown(event) {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault()
      if (this.element.value.trim()) {
        this.element.form.requestSubmit()
      }
    } else if (event.key === "Enter" && event.shiftKey) {
      requestAnimationFrame(() => this.resize())
    }
  }
}