(function(){
  'use strict';

  angular.module('themelook').controller('ThemeController',[
    '$http', '$window',
    'Theme', 'Category',

    function($http, $window, Theme, Category) {
      var vm = this;
      vm.categories = [];
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
