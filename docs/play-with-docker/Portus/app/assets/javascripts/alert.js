/* eslint-disable wrap-iife, no-param-reassign */
// TODO: remove the eslint disable parts once we move to proper modules.

(function () {
  (function (w) {
    w.refreshFloatAlertPosition = function () {
      var box = $('.float-alert');

      if ($(this).scrollTop() < 60) {
        box.css('top', (72 - $(this).scrollTop()) + 'px');
      }

      $(w).scroll(function scrollEvent() {
        if ($(this).scrollTop() > 60) {
          box.css('top', '12px');
        } else {
          box.css('top', (72 - $(this).scrollTop()) + 'px');
        }
      });
    };

    w.setTimeOutAlertDelay = function () {
      setTimeout(function () {
        $('.alert-hide').click();
      }, 4000);
    };

    w.setTimeOutAlertDelay();
  })(window);
}).call(window);
