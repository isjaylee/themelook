(function(){
  'use strict';

  angular.module('themelook').controller('CategoryShowController', [
    '$http', '$window',
    'Theme', 'Category',

    function($http, $window, Theme, Category){
      var vm = this;
      vm.themes = JSON.parse($window.Themelook.themes);
      vm.category = JSON.parse($window.Themelook.category);
      vm.categories = JSON.parse($window.Themelook.categories);


      formatPrice();

      function formatPrice() {
        _.each(vm.themes, function(theme){
          if (theme.price === 0) {
            theme.price = "Free";
          } else {
            theme.price = accounting.formatMoney(theme.price);
          }
        });
      }

    }]);
})();
