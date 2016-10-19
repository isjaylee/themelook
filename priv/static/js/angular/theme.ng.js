(function(){
  'use strict';

  angular.module('themelook').controller('ThemeController',[
    '$http', '$window',
    'Theme', 'Category',

    function($http, $window, Theme, Category) {
      var vm = this;

      getCategories();
      getThemes();

      function getCategories() {
        Category.getAll().then(
          function success(response) {
            vm.categories = response;
          }
        );
      }

      function getThemes() {
        Theme.getAll().then(
          function success(response) {
            vm.themes = response;

            _.each(vm.themes, function(theme){
              theme.price = accounting.formatMoney(theme.price);
            });
          }
        );
      }

    }]);

})();
