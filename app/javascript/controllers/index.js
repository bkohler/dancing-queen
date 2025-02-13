import { application } from "./application"

import ChatController from "./chat_controller.js"
import TextareaAutogrowController from "./textarea_autogrow_controller.js"
import ResetFormController from "./reset_form_controller.js"

application.register("chat", ChatController)
application.register("textarea-autogrow", TextareaAutogrowController)
application.register("reset-form", ResetFormController)
