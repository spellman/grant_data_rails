// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready = function () {
    "use strict";
    $("div.data-points").each(function (idx) {
        $(this).scrollLeft($(document).outerWidth());
    });
};

$(document).ready(ready);
$(document).on("page:load", ready);
