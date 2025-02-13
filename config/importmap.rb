# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Controllers
pin "controllers/application", to: "controllers/application.js", preload: true
pin "controllers/chat_controller", to: "controllers/chat_controller.js", preload: true
pin "controllers/textarea_autogrow_controller", to: "controllers/textarea_autogrow_controller.js", preload: true
pin "controllers/reset_form_controller", to: "controllers/reset_form_controller.js", preload: true
pin "controllers", to: "controllers/index.js", preload: true
