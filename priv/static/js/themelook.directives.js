(function() {
  'use strict';

    angular.module('themelook').filter('formatHtml', [
    '$filter',
    function($filter) {
      return function(input) {
        // Convert the input into a string.
        var text = ''+(input||'');

        return $filter('linky')(text).replace(/\&#10;/g, "&#10;<br>");
      };
    }

  ]);
})();
