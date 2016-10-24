(function(){
  'use strict';

  angular.module('themelook').controller('ThemeShowController', [
    '$http', '$window',
    'Theme', 'Category',

    function($http, $window, Theme, Category){
      var vm = this;
      vm.theme = JSON.parse($window.Themelook.theme);
      vm.categories = [];
      vm.searchThemes = searchThemes;

      getCategories();
      formatPrice();

      function getCategories() {
        Category.getAll().then(
          function success(response) {
            vm.categories = response;
          }
        );
      }

      function formatPrice() {
        if (vm.theme.price === 0) {
        vm.theme.price = "Free";
        } else {
        vm.theme.price = accounting.formatMoney(vm.theme.price);
        }
      }

      function searchThemes(params) {
        Theme.search(params).then(
          function success(response) {
          }
        );
      }


  }]);
})();
