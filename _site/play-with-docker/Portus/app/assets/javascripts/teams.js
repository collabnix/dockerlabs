jQuery(function ($) {
  $('#add_team_user_btn').on('click', function () {
    var team_id;

    $('#team_user_user').val('');
    $('#team_user_role').val('viewer');
    $('#add_team_user_form').toggle(400, 'swing', function () {
      if ($('#add_team_user_form').is(':visible')) {
        $('#add_team_user_btn i').addClass('fa-minus-circle');
        $('#add_team_user_btn i').removeClass('fa-plus-circle');
        $('#team_user_user').focus();
      } else {
        $('#add_team_user_btn i').removeClass('fa-minus-circle');
        $('#add_team_user_btn i').addClass('fa-plus-circle');
      }
      layout_resizer();
    });
    team_id = $('.remote').attr('id');
    set_typeahead(team_id + '/typeahead/%QUERY');
  });

  $('body').on('click', '.btn-edit-role', function (event) {
    var el = $(this).find('i.fa');

    if ($(this).hasClass('add')) {
      open_close_icon(el);
      $('#team_user_' + event.currentTarget.value + ' td .role').toggle();
      $('#change_role_team_user_' + event.currentTarget.value).toggle();
    } else if ($(this).hasClass('button_edit_team')) {
      $('.team_information').toggle();
      $('#update_team_' + event.currentTarget.value).toggle();
      $('#team_name').focus();
    }
  });

  $('#add_webhook_btn').unbind('click').on('click', function () {
    $('#webhook_url').val('');
    $('#webhook_username').val('');
    $('#webhook_password').val('');

    $('#add_webhook_form').toggle(400, 'swing', function () {
      if ($('#add_webhook_form').is(':visible')) {
        $('#add_webhook_btn i').addClass('fa-minus-circle');
        $('#add_webhook_btn i').removeClass('fa-plus-circle');
        $('#webhook_url').focus();
      } else {
        $('#add_webhook_btn i').removeClass('fa-minus-circle');
        $('#add_webhook_btn i').addClass('fa-plus-circle');
      }
      layout_resizer();
    });
  });

  $('body').on('click', '.btn-edit-webhook', function (event) {
    if ($(this).hasClass('button_edit_webhook')) {
      $('.webhook_information').toggle();
      $('#update_webhook_' + event.currentTarget.value).toggle();
      $('#webhook_url').focus();
      layout_resizer();
    }
  });

  $('#add_webhook_header_btn').unbind('click').on('click', function () {
    $('#webhook_header_name').val('');
    $('#webhook_header_value').val('');

    $('#add_webhook_header_form').toggle(400, 'swing', function () {
      if ($('#add_webhook_header_form').is(':visible')) {
        $('#add_webhook_header_btn i').addClass('fa-minus-circle');
        $('#add_webhook_header_btn i').removeClass('fa-plus-circle');
        $('#webhook_header_name').focus();
      } else {
        $('#add_webhook_header_btn i').removeClass('fa-minus-circle');
        $('#add_webhook_header_btn i').addClass('fa-plus-circle');
      }
      layout_resizer();
    });
  });

  $('#add_team_btn').on('click', function () {
    $('#team_name').val('');
    $('#team_description').val('');

    $('#add_team_form').toggle(400, 'swing', function () {
      if ($('#add_team_form').is(':visible')) {
        $('#add_team_btn i').addClass('fa-minus-circle');
        $('#add_team_btn i').removeClass('fa-plus-circle');
        $('#team_name').focus();
      } else {
        $('#add_team_btn i').removeClass('fa-minus-circle');
        $('#add_team_btn i').addClass('fa-plus-circle');
      }
      layout_resizer();
    });
  });
});
