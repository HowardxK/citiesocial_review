import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"    // stimulus.js

import "scripts/shared"    // js
import "scripts/frontend" // js

import "styles/shared"   // scss
import "styles/frontend" // scss