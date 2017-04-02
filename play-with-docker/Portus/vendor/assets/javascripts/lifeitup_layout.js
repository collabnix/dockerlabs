// to render the layout correctly in every browser/screen

window.$ = window.jQuery;
var alreadyResizing = false;

$(window).on("load", function() {

  layout_resizer ();
  add_view_image_icon ();
  resize_view_image_icon ();

});

$(window).on("resize", function() {

  layout_resizer ();
  resize_view_image_icon ();

});

$(document).bind("DOMSubtreeModified", function() {
  if (!alreadyResizing) {
    layout_resizer ();
  }
});

// triger the function to resize and to get the images size when a panel has been displayed
$(document).on('shown.bs.tab', 'a[data-toggle="tab"]', function () {
  layout_resizer();
  resize_view_image_icon();
})


function layout_resizer () {
  alreadyResizing = true;

  var screenHeight   = $(window).height();
  var headerHeight   = $("header").outerHeight();
  var footerHeight   = $("footer").outerHeight();
  var asideHeight    = $("aside ul").outerHeight();
  var sectionHeight  = $("section").outerHeight();

  if ( ( headerHeight + footerHeight + asideHeight ) > screenHeight && asideHeight > sectionHeight ) {

    $(".container-fluid").css({
      height : asideHeight + "px"
    });

  } else if ( ( headerHeight + footerHeight + sectionHeight ) > screenHeight && asideHeight < sectionHeight) {

    $(".container-fluid").css({
      height : sectionHeight + "px"
    });

  } else {

    $(".container-fluid").css({
      height : screenHeight - headerHeight - footerHeight + "px"
    });

  }

  alreadyResizing = false;
}
window.layout_resizer = layout_resizer;

// BOOTSTRAP INITS
// init popovers

$(function () {
  $('body').popover({
    selector: '[data-toggle="popover"]',
    trigger: 'focus'
  })
  // to destroy the popovers that are hidden
  $('[data-toggle="popover"]').on('hidden.bs.popover', function () {
    var popover = $('.popover').not('.in');
    if (popover) {
      popover.remove();
    }
  })
})

// init tooltip

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})


// View image
function add_view_image_icon () {
  $(".view-img-link").append("<div class='view-img'><i class='fa fa-external-link-square fa-3x fa-inverse'></i></div>")
}
window.add_view_image_icon = add_view_image_icon;

function resize_view_image_icon () {
  $(".view-img-link").each(function() {
    var imageHeight   = $(this).children("img").height()
    var imageWitdh    = $(this).children("img").width()
    var paddingVertical = (imageHeight - 44) / 2
    $(this).children(".view-img").css({
      height : imageHeight,
      width : imageWitdh,
      "padding-top" : paddingVertical
    })
  })

}
window.resize_view_image_icon = resize_view_image_icon;


// Functions for the mobile version
$(document).on("click", '#open_main_menu', open_mobile_menu);
var menu_open = false
function open_mobile_menu () {
  if (menu_open) {
    $('aside').css({'margin-left': '-250px'});
    menu_open = false;
  } else {
    $('aside').css({'margin-left': '0px'});
    menu_open = true
  }
}
window.open_mobile_menu = open_mobile_menu;

// Hide alert box instead of closing it
$(document).on('click', '.alert-hide', function() {
  $(this).parent().parent().fadeOut();
});
