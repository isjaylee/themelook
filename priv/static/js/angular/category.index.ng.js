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
        switch(sort) {
        case 'Price - High to Low':
          vm.themes = _.sortBy(vm.themes, function(theme) { return -theme.price } );
          break;
        case 'Price - Low to High':
          vm.themes = _.sortBy(vm.themes, function(theme) { return theme.price } );
          break;
        case 'Newest':
          vm.themes = _.sortBy(vm.themes, function(theme) {
            var date = new Date(theme.inserted_at);
            return -date;
          });
          break;
        case 'Oldest':
          vm.themes = _.sortBy(vm.themes, function(theme) {
            var date = new Date(theme.inserted_at);
            return date;
          });

          break;
        }
      }

      function loadMore(offset) {
        Theme.loadMore(offset).then(
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
