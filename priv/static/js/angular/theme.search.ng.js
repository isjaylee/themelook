(function(){
  'use strict';

  angular.module('themelook').controller('ThemeSearchController', [
    '$http', '$window', '$httpParamSerializerJQLike',
    'Theme',

    function($http, $window, $httpParamSerializerJQLike, Theme){
      var vm = this;
      var frameworks = ["HTML", "Shopify", "Wordpress", "Opencart", "Prestashop", "WooCommerce", "Magento", "BigCommerce", "Tumblr"];
      vm.themes = JSON.parse($window.Themelook.themes);
      vm.categories = JSON.parse($window.Themelook.categories);
      vm.searchParams = JSON.parse($window.Themelook.searchParams);
      vm.formatPrice = formatPrice;
      vm.sortThemes = sortThemes;
      vm.sortBy = 'Newest';
      vm.loadMore = loadMore;
      vm.showLoadMore = true;

      setThemeFramework();

      function setThemeFramework() {
        _.each(vm.themes, function(theme) {
          var themeCategories = _.map(theme.categories, 'name');
          var a = _.intersection(themeCategories, frameworks);
          theme['framework'] = a[0];
        });
        return vm.themes;
      }

      function formatPrice(price) {
        if (price === "0") {
          return 'Free';
        } else {
          return accounting.formatMoney(price);
        }
      }

      function sortThemes(sort){
        vm.sortBy = sort;
        var params = $httpParamSerializerJQLike(vm.searchParams); // Serialize params
        Theme.sort(sort, params, vm.themes.length).then(
          function success(response) {
            vm.themes = response;
            setThemeFramework();
          }
        );
      }

      function loadMore(offset) {
        var params = $httpParamSerializerJQLike(vm.searchParams); // Serialize params
        Theme.searchLoadMore(vm.sortBy, offset, params).then(
          function success(response){
            vm.themes = vm.themes.concat(response);

            if (response.length < 20) {
              vm.showLoadMore = false;
            }
            setThemeFramework();
          }
        );
      }

    }]);
})();
