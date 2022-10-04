// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
import jquery from 'jquery'
window.jQuery = jquery
window.$ = jquery


$( document ).ready(function() {
	$.ajax({
	    url: "pawns/log",
	    type: 'GET'
	});


    
    var input = document.querySelector("#file-upload");
    
    input.onchange = function () {
        if (input.files.length > 0) {
            let fileNameContainer = document.querySelector("#file-name");
            fileNameContainer.textContent = input.files[0].name;
        }
    }

});
