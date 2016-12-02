(function(){
  'use strict';

  angular.module('themelook').controller('CategoryIndexController', [
    '$http', '$window',
    'Theme', 'Category',

    function($http, $window, Theme, Category){
      var vm = this;
      vm.themes = JSON.parse($window.Themelook.themes);
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
        Category.indexPageSort(sort, vm.themes.length).then(
          function success(response) {
            vm.themes = response;
          }
        );
      }

      function loadMore(offset) {
        Theme.loadMore(vm.sortBy, offset).then(
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
