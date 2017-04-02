jQuery(function ($) {
  // Shows and hides the comment form
  $('#write_comment_repository_btn').unbind('click').on('click', function (_e) {
    $('#write_comment_form').toggle(400, 'swing', function () {
      if ($('#write_comment_form').is(':visible')) {
        $('#comment_body').focus();
        layout_resizer();
      }
    });
  });
});
