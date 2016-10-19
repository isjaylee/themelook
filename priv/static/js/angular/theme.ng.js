(function(){
  'use strict';

  angular.module('themelook').controller('ThemeController',[
    '$http', '$window',
    'Category',

    function($http, $window, Category) {
      var vm = this;
      vm.showCategory = showCategory;

      getCategories();

      function getCategories() {
        Category.getAll().then(
          function success(response) {
            vm.categories = response;
          }
        );
      }

      function showCategory() {
        
      }
    }]);

})();
