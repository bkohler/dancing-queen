import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { queenId: String }
  static targets = ["output"]

  async fetch() {
    try {
      const response = await fetch(`/queens/${this.queenIdValue}/biography`)
      const data = await response.json()
      this.outputTarget.innerHTML = data.biography
    } catch (error) {
      this.outputTarget.textContent = "Failed to fetch biography. Please try again."
    }
  }
}
