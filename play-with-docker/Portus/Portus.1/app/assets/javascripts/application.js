// jQuery
window.jQuery = require('jquery');
require('jquery-ujs');

// Bootstrap
require('bootstrap/js/transition');
require('bootstrap/js/tab');
require('bootstrap/js/tooltip');
require('bootstrap/js/popover');

// Life it up
require('vendor/lifeitup_layout');

// NOTE: should be removed in the future
require('vendor/bootstrap-typeahead');

// Require tree.
// NOTE: This should be moved into proper modules.
require('./alert');
require('./bootstrap');
require('./dashboard');
require('./includes/open_close_icon');
require('./includes/set_typehead');
require('./namespaces');
require('./open_search');
require('./repositories');
require('./teams');

// new modules structure
require('./modules/users');

