(function(){
  'use strict';

  angular.module('themelook').controller('ThemeController',[
    '$http', '$window',
    'Theme',

    function($http, $window, Theme) {
      var vm = this;
      vm.themes = JSON.parse($window.Themelook.themes);

      formatPrice();

      function formatPrice() {
        _.each(vm.themes, function(theme){
          if (theme.price === "0") {
            theme.price = "Free";
          } else {
            theme.price = accounting.formatMoney(theme.price);
          }
        });
      }

    }]);
})();
