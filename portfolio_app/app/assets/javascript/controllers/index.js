// Import and register all your controllers from the importmap via controllers/**/*_controller
//import { application } from "controllers/application"
//import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
//import DropdownController from "./dropdown_controller"; // Import the dropdown controller

//eagerLoadControllersFrom("controllers", application)

// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import DropdownController from "./dropdown_controller"; // Import the dropdown controller

application.register("dropdown", DropdownController); // Register the controller with Stimulus

