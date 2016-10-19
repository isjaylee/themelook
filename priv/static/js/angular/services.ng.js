(function(){
  'use strict';

  angular.module('kd.monitor').controller('ServicesController', [
    '$http', '$window',
    'Service',
    function ($http, $window, Service) {
      var vm = this;
      vm.showCreate = false;
      vm.createService = createService;
      vm.services = [];
      vm.serviceTypes = serviceTypes;
      vm.showLink = showLink;

      getServices();
      serviceTypes();

      function getServices() {
        Service.get().then(
          function success(response) {
            vm.services = response;
          }
        );
      }

      function serviceTypes() {
        return $http({
          method: 'GET',
          url: '/api/v1/service_types'
        }).then(
          function success(response) {
            vm.serviceTypes = response.data;
          }
        );
      }


      function createService(serviceParams) {
        Service.create(serviceParams).then(
          function success(response) {
            vm.services.push(response);
            vm.showServiceCreate = false;
          }
        );
      }

      function showLink(service) {
        return '/services/' + service.id;
      }
    }]);
})();
