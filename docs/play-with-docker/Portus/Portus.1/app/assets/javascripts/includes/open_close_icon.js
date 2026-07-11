/* eslint-disable wrap-iife, no-param-reassign */
// TODO: remove the eslint disable parts once we move to proper modules.

(function () {
  (function (w) {
    w.open_close_icon = function (icon) {
      if (icon.hasClass('fa-close')) {
        icon.removeClass('fa-close');
        icon.addClass('fa-pencil');
      } else {
        icon.removeClass('fa-pencil');
        icon.addClass('fa-close');
      }
    };
  })(window);
}).call(window);
