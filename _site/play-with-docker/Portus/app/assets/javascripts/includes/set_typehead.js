/* eslint-disable wrap-iife, no-param-reassign */
// TODO: remove the eslint disable parts once we move to proper modules.

(function () {
  (function (w) {
    var bloodhound;

    w.set_typeahead = function (url) {
      $('.remote .typeahead').typeahead('destroy');
      bloodhound = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
          cache: false,
          url: url,
          wildcard: '%QUERY',
        },
      });
      bloodhound.initialize();
      $('.remote .typeahead').typeahead({ highlight: true }, {
        displayKey: 'name',
        source: bloodhound.ttAdapter(),
      });
    };
  })(window);
}).call(window);
