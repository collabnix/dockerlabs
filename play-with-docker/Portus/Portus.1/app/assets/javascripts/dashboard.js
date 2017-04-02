jQuery(function ($) {
  $('#starred a').on('click', function (e) {
    e.preventDefault();
    $(this).tab('show');
  });

  $('#all a').on('click', function (e) {
    e.preventDefault();
    $(this).tab('show');
  });

  $('#personal a').on('click', function (e) {
    e.preventDefault();
    $(this).tab('show');
  });
});
