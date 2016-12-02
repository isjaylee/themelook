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
      vm.formatPrice = formatPrice;
      vm.sortThemes = sortThemes;
      vm.sortBy = 'Newest';
      vm.loadMore = loadMore;
      vm.showLoadMore = true;

      function formatPrice(price) {
        if (price === "0") {
          return 'Free';
        } else {
          return accounting.formatMoney(price);
        }
      }

      function sortThemes(sort){
        vm.sortBy = sort;
        Category.sort(sort, vm.category, vm.themes.length).then(
          function success(response) {
            vm.themes = response;
          }
        );
      }

      function loadMore(offset) {
        Category.loadMore(vm.sortBy, vm.category, offset).then(
          function success(response){
            vm.themes = vm.themes.concat(response);

            if (response.length < 16) {
              vm.showLoadMore = false;
            }
          }
        );
      }

    }]);
})();
