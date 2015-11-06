// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var scrollDataPointsDivsToRight = function () {
  "use strict";
  $("div.data-points").each(function (idx) {
    $(this).scrollLeft($(document).outerWidth());
  });
};

var ready = function () {
  "use strict";
  scrollDataPointsDivsToRight();
};

$(document).ready(ready);
$(document).on("page:load", ready);
