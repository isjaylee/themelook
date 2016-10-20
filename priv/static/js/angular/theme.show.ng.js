(function(){
  'use strict';

  angular.module('themelook').controller('ThemeShowController', [
    '$http', '$window',
    'Theme', 'Category',

    function($http, $window, Theme, Category){
      var vm = this;
      vm.theme = JSON.parse($window.Themelook.theme);
      vm.categories = [];

      getCategories();

      function getCategories() {
        Category.getAll().then(
          function success(response) {
            vm.categories = response;
          }
        );
      }

  }]);
})();
