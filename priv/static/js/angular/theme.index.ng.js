(function(){
  'use strict';

  angular.module('themelook').controller('ThemeController',[
    '$http', '$window',
    'Theme', 'Category',

    function($http, $window, Theme, Category) {
      var vm = this;
      vm.categories = [];
      vm.themes = [];
      vm.originalThemesList = []; // Original list of all themes. Way to reference the original list.
      vm.resetThemesList = resetThemesList;

      vm.filterByCategory = filterByCategory;

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
            vm.originalThemesList = response; // Preserve list so when we're filtering, we can always reference original list.

            _.each(vm.themes, function(theme){
              if (theme.price === 0) {
                theme.price = "Free";
              } else {
                theme.price = accounting.formatMoney(theme.price);
              }
            });
          }
        );
      }

      function resetThemesList() {
        vm.themes = vm.originalThemesList;
      }

      function filterByCategory(category) {
        vm.themes = vm.originalThemesList;
        vm.themes = _.filter(vm.themes, function(theme){
          return _.some(theme.categories, {id: category.id});
        });
      }

    }]);
})();
