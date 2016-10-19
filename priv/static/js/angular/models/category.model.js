(function() {
  'use strict';

  angular.module('themelook').factory('Category', [
    '$http', '$log',

    function($http, $log) {
      $log.info('{Model} Defining the Category model.');

      return {
        getAll:  getAll
      };

      /*----------------------------------------------------------------------------------------------
       * MANAGEMENT METHODS
       *--------------------------------------------------------------------------------------------*/
      function  getAll() {
        return $http({
          method: 'GET',
          url: _url()
        }).then(_success);
      }

      /*----------------------------------------------------------------------------------------------
      /*----------------------------------------------------------------------------------------------
       * HELPER METHODS
       *--------------------------------------------------------------------------------------------*/

      // This is a general success that strips response data off of the promise.
      function _success(response) {
        return response.data;
      }

      function _url() {
        return '/api/v1/categories';
      }

  }]);
})();
