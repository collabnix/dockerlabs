// search
$(function () {
  // define the initial array
  var keypressed = void 0;
  var crtl = 17;
  var space = 32;
  var keys = [{
    key: crtl,
    v: false,
  }, {
    key: space,
    v: false,
  }];

  var openSearch = function openSearch() {
    if ($(window).scrollTop() > 0) {
      $('html,body').unbind().animate({ scrollTop: 0 }, 500);
    }
    $('.search-field').val('').focus();
  };

  var activateSearch = function activateSearch() {
    var performSearch = 0;
    $.each(keys, function (i) {
      if (keys[i].v === true) {
        performSearch++;
      }
      if (performSearch > 1) {
        openSearch();
      }
    });
  };

  var searchKey = function searchKey(k, b) {
    $.each(keys, function (i) {
      if (keys[i].key === k) {
        keys[i].v = b;
      }
    });
    activateSearch();
  };

  $(document).on('keydown', function (e) {
    if (e.keyCode === crtl || e.keyCode === space) {
      // if crtl is currently pressed, the spacebar default action wont be triggered
      if (keys[0].v) {
        e.preventDefault();
      }
      keypressed = e.keyCode;
      searchKey(keypressed, true);
    }
  });
  $(document).on('keyup', function (e) {
    if (e.keyCode === crtl || e.keyCode === space) {
      keypressed = e.keyCode;
      searchKey(keypressed, false);
    }
  });
});
