(function(){
  'use strict';

  angular.module('themelook').controller('ThemeShowController', [
    '$http', '$window',
    'Theme', 'Category',

    function($http, $window, Theme, Category){
      var vm = this;
      vm.theme = JSON.parse($window.Themelook.theme);
      vm.formatPrice = formatPrice;
      vm.searchThemes = searchThemes;
      vm.listCategories = listCategories;

      function formatPrice(price) {
        if (price === 0) {
          return 'Free';
        } else {
          return accounting.formatMoney(price);
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
