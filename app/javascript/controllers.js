import { Application, Controller } from "@hotwired/stimulus"

const application = Application.start()

// Chat Controller
class ChatController extends Controller {
  static targets = ["messages", "input"]

  connect() {
    this.scrollToBottom()
  }

  scrollToBottom() {
    const messages = this.messagesTarget
    messages.scrollTop = messages.scrollHeight
  }

  submit(event) {
    if (!this.inputTarget.value.trim()) {
      event.preventDefault()
      return
    }
  }

  messagesTargetConnected() {
    this.scrollToBottom()
  }

  messagesTargetMutated() {
    this.scrollToBottom()
  }

  reset() {
    this.inputTarget.value = ""
    this.inputTarget.style.height = "auto"
  }
}

// Textarea Autogrow Controller
class TextareaAutogrowController extends Controller {
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

// Reset Form Controller
class ResetFormController extends Controller {
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

// Register Controllers
application.register("chat", ChatController)
application.register("textarea-autogrow", TextareaAutogrowController)
application.register("reset-form", ResetFormController)

export { application }