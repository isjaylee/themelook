(function(){
  'use strict';

  angular.module('themelook').controller('ThemeShowController', [
    '$http', '$window',
    'Theme', 'Category',

    function($http, $window, Theme, Category){
      var vm = this;
      vm.theme = JSON.parse($window.Themelook.theme);
      vm.categories = JSON.parse($window.Themelook.categories);
      vm.searchThemes = searchThemes;
      vm.listCategories = listCategories;

      formatPrice();

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

      function listCategories(categories) {
        var categoryList = [];
        _.each(categories, function(category){
          if (!_.isEmpty(category)) { categoryList.push(category.name) }
        });
        return categoryList.join(', ');
      }


  }]);
})();
