// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

// Import and register all controllers
import ChatController from "./controllers/chat_controller"
import TextareaAutogrowController from "./controllers/textarea_autogrow_controller"
import ResetFormController from "./controllers/reset_form_controller"

application.register("chat", ChatController)
application.register("textarea-autogrow", TextareaAutogrowController)
application.register("reset-form", ResetFormController)
