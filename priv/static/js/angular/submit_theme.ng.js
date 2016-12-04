(function(){
  'use strict';

  angular.module('themelook').controller('SubmitThemeController', [
    '$http', '$window',

    function($http, $window){
      var vm = this;
      vm.categories = _.sortBy(JSON.parse($window.Themelook.categories), 'name');
      vm.showSubmitMsg = false;
      vm.submitForm = submitForm;

      function submitForm(params) {
        params.categories = _.keys(params.categories).join(', ');
        return $http({
          method: 'POST',
          data: params,
          url: `/api/v1/send_submit`
        }).then(
          function success(response) {
            vm.showSubmitMsg = true;
          }
        );
      }

    }]);
})();
